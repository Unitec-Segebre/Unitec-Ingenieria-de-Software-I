Rails.application.routes.draw do
  root 'sessions#new'

  resources :users

  resources :variables, only: [:index, :destroy, :create]

  resources :categories, only: [:index, :destroy, :create]

  resources :projects, only: [:index, :new, :create, :show] do
    resources :lots, only: [:new, :create, :show]
  end

end
