Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Ruta de Login (Solo POST es necesario en una API)
  post "/auth/login", to: "auth#login"

  # Rutas protegidas
  resources :skills, only: [ :index, :show, :create, :update, :destroy ]
  resources :projects, only: [ :index, :show, :create, :update, :destroy ]

  resources :users, only: [], param: :email do
    get :profile, on: :collection
  end

  # Documentation Endpoints (Solo se definen UNA vez)
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
end
