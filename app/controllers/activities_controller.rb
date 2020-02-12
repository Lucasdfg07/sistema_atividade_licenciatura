class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :pertence, only: [:show, :edit]

  require './lib/generate_pdf'
  # GET /activities
  # GET /activities.json
  def index
    @data_prazo = PrazoAtpa.last.prazo_final.strftime("%d/%m/%Y")
    @data = PrazoAtpa.last.prazo_final.to_datetime

    if params[:page].present? && params[:page] > "1"
      @cont = (params[:page].to_i - 1) * 400
    else
      @cont = 0
    end

    # Função para pesquisa do aluno
    if params[:search].present?
      pesquisa_atividades
    elsif params[:search_periodo].present? && params[:search_curso].blank?
      @activities_geral = Activity.joins(:user).merge(User.where("periodo LIKE :search_periodo", search_periodo: "%#{params[:search_periodo]}%")).paginate(page: params[:page], per_page: 400)
    elsif params[:search_curso].present? && params[:search_periodo].blank?
      @activities_geral = Activity.joins(:user).merge(User.where("licenciatura LIKE :search_curso", search_curso: "%#{params[:search_curso]}%")).paginate(page: params[:page], per_page: 400)
    elsif params[:search_curso].present? && params[:search_periodo].present?
      @activities_geral = Activity.joins(:user).merge(User.where("licenciatura LIKE :search_curso AND periodo LIKE :search_periodo", search_curso: "%#{params[:search_curso]}%", search_periodo: "%#{params[:search_periodo]}%")).paginate(page: params[:page], per_page: 400)
    else
      @activities = Activity.order(status: :DESC)
      @activities_geral = Activity.order(status: :DESC).paginate(page: params[:page], per_page: 400)
    end

    @activities_aluno = Activity.order(status: :DESC)
    @activities_pendente = Activity.order(status: :DESC).paginate(page: params[:page], per_page: 400)
    
    @activities_deferido = Activity.order(status: :DESC).paginate(page: params[:page], per_page: 400)

    respond_to do |format|
     format.html
     format.pdf do
       @users = User.all
       @activities = Activity.all

       @user_nome = params['nome']

       pdf = RelatorioPdf.new(@users, @activities, @user_nome, :margin => [50])
       send_data pdf.render, filename: 'relatorio.pdf', type: 'application/pdf', disposition: 'inline'
     end
    end
  end

  def pesquisa_atividades
    if current_user.role == "admin"
      @activities_geral = Activity.where("lower(nome_usuario) LIKE :search", search: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 400)
    else
      @usuario = current_user.nome
      @activities = current_user.activities.order(status: :DESC).where("lower(titulo) LIKE :search OR lower(status) LIKE :search OR lower(relatorio) LIKE :search OR lower(edited_by) LIKE :search OR lower(nome_grupo) LIKE :search OR lower(local_realizacao_atividade) LIKE :search OR lower(relatorio) LIKE :search OR lower(status) LIKE :search OR lower(feedback) LIKE :search OR lower(edited_by) LIKE :search OR lower(nome_do_evento) LIKE :search", search: "%#{params[:search].downcase}%")
      @atividades_cadastradas = Activity.where("nome_usuario = '"+ @usuario +"'").count
    end
  end

  def atualizar_prazo
    @prazo = PrazoAtpa.create(prazo_params)
    @prazo.update(admin_responsavel: current_user.nome)

    redirect_to activities_path , notice: 'Prazo salvo com sucesso!'
  end

  # GET /activities/1
  # GET /activities/1.json
  def show

  end

  # GET /activities/new
  def new
    @activity = Activity.new
    @activity_grupo_0 = [ "Palestras", "Seminários", "Congressos", "Simpósios", "Fóruns", "Encontros", "Mesas Redondas e Similares"]
    @value_id = params['id']
    @value_nome = params['nome']

    session[:variavel_nome] = @value_nome
    session[:userID] = @value_id

  end

  # GET /activities/1/edit
  def edit
    @activity_grupo_0 = [ "Palestras", "Seminários", "Congressos", "Simpósios", "Fóruns", "Encontros", "Mesas Redondas e Similares"]
    
    @cont = 0
    @avaliacoes = RegistroAvaliacao.order(created_at: :DESC)
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    @activity.nome_usuario = @activity.user.nome
    @activity.status = "Pendente"
    @activity_grupo_0 = Activity.all


    @grupo_database = Grupo.find_by(grupo: @activity.grupo)

    if @activity.grupo == @grupo_database.grupo
      @activity.nome_grupo = @grupo_database.nome_grupo
    end

    if current_user.role == "admin"
      @activity.user_id = session[:userID]
    end

    @value_nome = session[:variavel_nome]
    @value_id = session[:userID]

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_show_path(:id => @activity.id), notice: 'Atividade criada com sucesso.'  }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end

    if current_user.role != "admin"
      AaccMailer.envio_atividade(current_user, @activity).deliver
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    if current_user.role == "admin"
      @activity.edited_by = current_user.nome
    end

    respond_to do |format|
      if @activity.update(activity_params)

        # Achar o grupo da tabela Grupo
        @grupo = Grupo.find_by(grupo: @activity.grupo)

        # Atualizar o nome_grupo da tabela Activity pelo dado resgatado da tabela Grupo
        @atualizar_nome_grupo = @activity.update(nome_grupo: @grupo.nome_grupo)

        # Encontrar usuário para mandar o email de aviso de avaliação da AACC para o mesmo.
        @aluno_da_atividade = User.find_by(nome: @activity.nome_usuario)

        if current_user.role != "admin"
          AaccMailer.editou_atividade(current_user, @activity).deliver
        else
          @id = @aluno_da_atividade.id
          @nome = @activity.nome_usuario
          @status = @activity.status
          @id_activity = @activity.id

          @registro = RegistroAvaliacao.create(aluno_id: @id, nome_aluno: @nome, status: @status, avaliador: current_user.nome, id_activity: @id_activity)
          AaccMailer.envio_aluno(current_user, @activity, @aluno_da_atividade).deliver
        end

        format.html { redirect_to @activity, notice: 'Atividade atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Atividade excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  def export
    pdf = GeneratePdf::activity(user, user.activities)
    send_data pdf.render,
      filename: "relatorioativ",
      type: 'application/pdf',
      disposition: 'inline'
    end

  def pertence
    if ((current_user.role != "admin")&&(current_user.id != @activity.user_id))
      flash[:notice] = "Essa atividade não está acessível para você"
      redirect_to activities_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])

      #@activity = Activity.new(activity_params)
      #current_user = @activity.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:edited_by, :grupo, :tipo, :status ,:feedback, :data_evento, :titulo, :local_realizacao_atividade, :nome_do_evento, :relatorio, :user_id, :hora_computada, {documents: []})
    end

    def prazo_params
      params.permit(:prazo_final)
    end
end
