class AaccMailer < ActionMailer::Base
  default :from => 'napp_dirlic.centro@iff.edu.br'

  def envio_atividade(current_user, activity)
    @current_user = current_user
    @activity = activity

    mail(:to => 'napp_dirlic.centro@iff.edu.br', :subject => 'Envio de AACC')
  end

  def editou_atividade(current_user, activity)
    @current_user = current_user
    @activity = activity

    mail(:to => 'napp_dirlic.centro@iff.edu.br', :subject => 'Edição de AACC')
  end

  def envio_aluno(current_user, activity, aluno_da_atividade)
    @current_user = current_user
    @activity = activity
    @aluno_da_atividade = aluno_da_atividade


    mail(:to => @aluno_da_atividade.email, :subject => 'Avaliação de AACC')
  end

end
