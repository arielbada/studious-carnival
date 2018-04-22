Rails.application.routes.draw do
  resources :secciones
  resources :seguimientos
  devise_for :users
  resources :alumnos
  resources :alumno_imports
  resources :alumno_observaciones
  resources :seguimiento_imports
  resources :localidades
  resources :sedes
  root to: 'alumnos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
