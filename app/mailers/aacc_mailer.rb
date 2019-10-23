class AaccMailer < ActionMailer::Base
  default :from => 'napp_dirlic.centro@iff.edu.br'

  def envio_atividade(current_user)
    @current_user = current_user

    mail(:to => 'napp_dirlic.centro@iff.edu.br', :subject => 'AACC')
  end

end
