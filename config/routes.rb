Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  get "/experiences", to: "experiences#index", as: :experiences
  resources :journeys, only: %i[show new create edit update destroy] do
    resources :experiences, only: %i[new create]
  end

  get "/:username", to: "users#profile_page", as: :profile_page
end
