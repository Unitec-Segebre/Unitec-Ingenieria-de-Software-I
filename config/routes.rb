Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, except: [:new, :edit]

  resources :variables, only: [:index, :destroy, :create]

  resources :categories, only: [:index, :destroy, :create]

  resources :projects, only: [:index, :create, :show] do
    resources :lots, only: [:create, :show, :update] do
      get 'report'
      post 'report'
      resources :lots, only: [:create, :show] do
        post 'values', on: :member
      end
      resources :variables, only: [] do
        get 'history'
      end
    end
	end
end
