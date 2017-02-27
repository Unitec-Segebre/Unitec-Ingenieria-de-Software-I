Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, except: :new

  resources :variables, only: [:index, :destroy, :create]

  resources :categories, only: [:index, :destroy, :create]

  resources :projects, only: [:index, :create, :show] do
    resources :lots, only: [:create, :show]
  end

end
