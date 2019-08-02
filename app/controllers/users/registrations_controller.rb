# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

  # Realizar update de informações sem precisar inserir senha. Sobrescreve devise
  def update_resource(resource, params)
    resource.update_without_password(params)
  end


  def after_sign_up_path_for(resource)
      @users = User.create(user_params_create)

      signed_in_root_path(resource)
  end


  def update
    @users = current_user.update(user_params)
    
    redirect_to welcome_index_path
  end


  def user_params_create
    params.require(:user).permit(:nome, :email, :matricula, :licenciatura, :inicio_ano, :termino_ano, :password, :password_confirmation, :avatar)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:nome, :email, :matricula, :licenciatura, :inicio_ano, :termino_ano, :avatar)
  end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:nome])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:matricula])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:licenciatura])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:inicio_ano])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:termino_ano])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:cargahoraria])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:nome])
     devise_parameter_sanitizer.permit(:account_update, keys: [:matricula])
     devise_parameter_sanitizer.permit(:account_update, keys: [:licenciatura])
     devise_parameter_sanitizer.permit(:account_update, keys: [:inicio_ano])
     devise_parameter_sanitizer.permit(:account_update, keys: [:termino_ano])
     devise_parameter_sanitizer.permit(:account_update, keys: [:cargahoraria])
     devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
   end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
