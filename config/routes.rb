Rails.application.routes.draw do
  get 'sessions/new'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'activities/horas'
  get 'activities/show'

  get 'activities/deferidos'
  get 'activities/indeferidos'
  get 'activities/pendentes'
  get 'activities/atividades_geral'
  get 'activities/revisar'
  get 'activities/export'

  get 'control_users/horas_user'
  get 'control_users/index'
  get 'control_users/horas_user'
  get 'control_users/cursos'
  get 'control_users/graficos'

  get 'welcome/index'
  get 'welcome/documents'
  get 'welcome/historico'

  get 'evento/index'
  post 'evento/create'

  get 'duvida/index'
  post 'duvida/create'
  get 'duvida/edit'
  get 'duvida/update'
  post 'duvida/update'

  get 'welcome/duvidas'
  get 'welcome/quem_somos'

  post 'welcome/atualizar_prazo'

  # Routes Sistema de Estágio
  get 'estagio_welcome/index'
  post 'estagio_welcome/index'

  get 'estagio_welcome/pendente'
  post 'estagio_welcome/pendente'

  get 'estagio_welcome/edit'
  post 'estagio_welcome/edit'

  get 'estagio_welcome/update'
  post 'estagio_welcome/update'

  get 'estagio_welcome/status_impressao'
  post 'estagio_welcome/status_impressao'

  get 'estagio_welcome/pdf_visualiza'

  get 'relatorio_centro/index'
  get 'relatorio_guarus/index'

  get 'relatorio_publico/index'

  get 'relatorio_particular/index'
  get 'relatorio_particular/edit'

  get 'relatorio_particular/update'
  post 'relatorio_particular/update'

  get 'relatorio_particular/create'
  post 'relatorio_particular/create'

  get 'relatorio_naoformal/index'
  get 'relatorio_naoformal/edit'

  get 'relatorio_naoformal/create'
  post 'relatorio_naoformal/create'

  get 'relatorio_naoformal/edit'
  post 'relatorio_naoformal/edit'

  get 'relatorio_naoformal/update'
  post 'relatorio_naoformal/update'

  get 'relatorio_centro/create'
  post 'relatorio_centro/create'

  get 'relatorio_centro/edit'
  post 'relatorio_centro/edit'

  get 'relatorio_centro/update'
  post 'relatorio_centro/update'

  get 'relatorio_guarus/create'
  post 'relatorio_guarus/create'

  get 'relatorio_guarus/edit'
  post 'relatorio_guarus/edit'

  get 'relatorio_guarus/update'
  post 'relatorio_guarus/update'

  get 'relatorio_publico/create'
  post 'relatorio_publico/create'

  get 'relatorio_publico/edit'
  post 'relatorio_publico/edit'

  get 'relatorio_publico/update'
  post 'relatorio_publico/update'

  get 'pdf_geral/particular'
  get 'pdf_geral/publico'
  get 'pdf_geral/centro'
  get 'pdf_geral/guarus'
  get 'pdf_geral/naoformal'
  get 'pdf_geral/publico'

  get 'pdf_geral/update_particular'
  post 'pdf_geral/update_particular'

  get 'pdf_geral/update_publico'
  post 'pdf_geral/update_publico'

  get 'pdf_geral/update_centro'
  post 'pdf_geral/update_centro'

  get 'pdf_geral/update_guarus'
  post 'pdf_geral/update_guarus'

  get 'pdf_geral/update_naoformal'
  post 'pdf_geral/update_naoformal'

  get '/delete', to: 'activities#destroy', as: 'delete'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'welcome#index'

  resources :activities do
  	  member do
        get 'export'
   	  end
   end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
