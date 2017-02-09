Rails.application.routes.draw do
  root 'sessions#new'

  resources :projects, only: [:index, :new, :show] do
    resources :lots, only: :new
  end

end
