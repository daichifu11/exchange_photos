Rails.application.routes.draw do
  root 'tutorial#top'
  get "/other_user_show/:id" => "users#other_user_show"
  get "/terms" => "tutorial#terms"
  get "/privacy" => "tutorial#privacy"


  devise_for :users, controllers: { :omniauth_callbacks => 'omniauth_callbacks' }

  resources :users, only: [:show, :index] do
    member do
      get :following, :followers
    end
  end

  resources :messages, only: :create do
    resources :comments, only: :create
  end
    
  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:create, :show, :index]
  resources :notifications, only: :index
end
