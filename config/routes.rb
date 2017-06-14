Rails.application.routes.draw do
  root 'sessions#new'


  resources :users, except: [:new, :edit]

  resources :variables, only: [:index, :destroy, :create]

  resources :categories, only: [:index, :destroy, :create]

  resources :projects, only: [:index, :create, :show] do
    resources :lots, only: [:create, :show, :update] do
      post '', to: 'lots#date'
      get 'report'
      post 'report'
      resources :lots, only: [:create, :show] do
        post 'values', on: :member
      end
      resources :variables, only: [] do
        get 'history'
        post 'history'
      end
    end
	end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
