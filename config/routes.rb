Rails.application.routes.draw do
  resources :projects
  get 'lotes/new'

  get 'lotes/show'

  get 'lotes/index'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
