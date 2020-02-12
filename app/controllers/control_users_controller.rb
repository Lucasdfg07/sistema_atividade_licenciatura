class ControlUsersController < ApplicationController
  	before_action :authenticate_user!
  	before_action :is_admin, only: [:index, :horas_user]

  def index
    # Paginate Id increment
    if params[:page].present? && params[:page] > "1"
      @cont = (params[:page].to_i - 1) * 30
    else
      @cont = 0
    end

    if params[:search].present?
      @users = User.order(nome: :ASC).where("lower(nome) LIKE :search OR lower(matricula) LIKE :search OR lower(licenciatura) LIKE :search", search: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 30)
    else
      @users = User.order(nome: :ASC).paginate(page: params[:page], per_page: 30)
    end
  end

  def graficos
    @users = User.all

    # Dados para o gráfico
    @ciencias = User.where(licenciatura: "Ciências da Natureza").group_by_month(:created_at).count
    @educacao = User.where(licenciatura: "Educação Física").group_by_month(:created_at).count
    @geografia = User.where(licenciatura: "Geografia").group_by_month(:created_at).count
    @letras = User.where(licenciatura: "Letras: Português e Literaturas").group_by_month(:created_at).count
    @matematica = User.where(licenciatura: "Matemática").group_by_month(:created_at).count
    @teatro = User.where(licenciatura: "Teatro").group_by_month(:created_at).count
    

    @ciencia_quant = 0
    @educacao_quant = 0
    @geografia_quant = 0
    @letras_quant = 0
    @matematica_quant = 0
    @teatro_quant = 0

    @aluno_ciencias_sem_atividades = 0
    @aluno_educacao_sem_atividades = 0
    @aluno_geografia_sem_atividades = 0
    @aluno_letras_sem_atividades = 0
    @aluno_matematica_sem_atividades = 0
    @aluno_teatro_sem_atividades = 0
    
    @users.each do |user|
      if user.licenciatura == "Ciências da Natureza" 
        if user.cargahoraria.sum >= 200 
          @ciencia_quant += 1;
        elsif user.cargahoraria.sum == 0
          @aluno_ciencias_sem_atividades += 1;
        end


       elsif user.licenciatura == "Educação Física" 
        if user.cargahoraria.sum >= 200 
          @educacao_quant += 1;
        elsif user.cargahoraria.sum == 0
          @aluno_educacao_sem_atividades += 1;
        end

       elsif user.licenciatura == "Geografia"
        if user.cargahoraria.sum >= 200 
          @geografia_quant += 1;
        elsif user.cargahoraria.sum == 0
          @aluno_geografia_sem_atividades += 1;
        end

       elsif user.licenciatura == "Letras: Português e Literaturas" 
        if user.cargahoraria.sum >= 200 
          @letras_quant += 1;
        elsif user.cargahoraria.sum == 0
          @aluno_letras_sem_atividades += 1;
        end

       elsif user.licenciatura == "Matemática" 
        if user.cargahoraria.sum >= 200 
          @matematica_quant += 1;
        elsif user.cargahoraria.sum == 0
          @aluno_matematica_sem_atividades += 1;
        end

       elsif user.licenciatura == "Teatro"
        if user.cargahoraria.sum >= 200 
          @teatro_quant += 1;
        elsif user.cargahoraria.sum == 0
          @aluno_teatro_sem_atividades += 1;
        end
      end
    end 
  end
  
  def cursos
    @cont = 0
    @curso_atual = params[:curso]

    if params[:search].present?
      @users = User.order(nome: :ASC).where("lower(nome) LIKE :search OR lower(matricula) LIKE :search", search: "%#{params[:search].downcase}%")
    else
      @users = User.order(nome: :ASC)
    end
  end

	def is_admin
		if(current_user.role != "admin")
      	redirect_to root_path
      	flash[:notice] = "Você não tem acesso ao catálogo de usuários"
    end
  end

  def horas_user
        @users = User.all
        @value_nome = params['nome']
  end
end
