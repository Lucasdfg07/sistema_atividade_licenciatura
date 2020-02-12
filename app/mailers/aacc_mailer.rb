class AaccMailer < ActionMailer::Base
  default :from => 'nappdirlic.centro@gmail.com'

  def envio_atividade(current_user, activity)
    @current_user = current_user
    @activity = activity

    mail(:to => 'nappdirlic.centro@gmail.com', :subject => 'Envio de AACC')
  end

  def editou_atividade(current_user, activity)
    @current_user = current_user
    @activity = activity

    mail(:to => 'nappdirlic.centro@gmail.com', :subject => 'Edição de AACC')
  end

  def envio_aluno(current_user, activity, aluno_da_atividade)
    @current_user = current_user
    @activity = activity
    @aluno_da_atividade = aluno_da_atividade


    mail(:to => @aluno_da_atividade.email, :subject => 'Sua AACC foi Avaliada!')
  end

end
