Rails.application.routes.draw do
  root 'tutorial#top'
  devise_for :users, controllers: { :omniauth_callbacks => 'omniauth_callbacks' }
  resources :users, only: [:show, :index] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: :create do
    resources :comments, only: :create
  end
  resources :rooms, only: [:create, :show, :index]
  get "/other_user_show/:id" => "users#other_user_show"
end