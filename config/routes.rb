Rails.application.routes.draw do
  root 'sessions#new'

  resources :categories, only: [:index, :destroy]

  resources :projects, only: [:index, :new, :create, :show] do
    resources :lots, only: [:new, :create]
  end

end