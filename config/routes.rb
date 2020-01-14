Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'omniauth_callbacks' }
  get 'users/:id/show' => 'users#show'
  root 'tutorial#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
