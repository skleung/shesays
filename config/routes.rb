Rails.application.routes.draw do

  resources :companies do
    resources :reviews, only: [:new, :create]
  end

  root to: 'welcome#index'
  devise_for :users
  resources :users

  get 'search' => 'companies#search'

  get "*path", :to => "application#routing_error"
end
