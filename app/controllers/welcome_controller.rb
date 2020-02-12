class WelcomeController < ApplicationController
  def index
    
  end

  def atualizar_prazo

    @prazo = PrazoAtpa.create(prazo_params)
    @prazo.update(admin_responsavel: current_user.nome)

    redirect_to activities_path , notice: 'Prazo salvo com sucesso!'
  end

  def prazo_params
    params.permit(:prazo_final)
  end
end
