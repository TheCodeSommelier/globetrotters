Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: "pages#home"

  resources :users, only: %i[index]


  get "experiences/:id/like", to: "experiences#like", as: :like_experience

  get "up" => "rails/health#show", as: :rails_health_check

  get "/experiences", to: "experiences#index", as: :experiences

  resources :journeys, only: %i[show new create edit update destroy] do
    resources :experiences, only: %i[new create]
  end

  # resources :experiences, only: [:show] do
  #   member do
  #     patch "like", to: "experiences#like"
  #   end
  # end

  post "saved_experience/:experience_id", to: "saved_experiences#create", as: :saved_experience

  delete "/saved_experience/:id", to: "saved_experiences#destroy", as: :delete_saved_experience



  resources :chatrooms, only: %i[index show create] do
    resources :messages, only: :create
  end

  get "/:username", to: "users#profile_page", as: :profile_page

end
