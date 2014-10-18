Rails.application.routes.draw do
  resources :companies

  resources :reviews

  root to: 'welcome#index'
  devise_for :users
  resources :users

  get 'search' => 'companies#search'
end
