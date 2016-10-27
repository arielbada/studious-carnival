Rails.application.routes.draw do
  resources :seguimientos
  devise_for :users
  resources :alumnos
  resources :localidades
  resources :sedes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
