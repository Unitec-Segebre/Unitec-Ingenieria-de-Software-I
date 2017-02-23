Rails.application.routes.draw do
  root 'sessions#new'

  resources :variables, only: [:index, :destroy, :create]

  resources :categories, only: [:index, :destroy, :create]

  resources :projects, only: [:index, :new, :create, :show] do
    resources :lots, only: [:new, :create]
  end

end