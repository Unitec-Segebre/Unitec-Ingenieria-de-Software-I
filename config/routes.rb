Rails.application.routes.draw do
  get 'lots/index'

  get 'lots/new'

  get 'lots/show'

  get 'projects/index'

  get 'projects/new'

  get 'projects/show'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
