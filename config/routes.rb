Rails.application.routes.draw do
  resources :users
  get 'static_pages/home'

  get 'static_pages/help'
  get 'static_pages/search'
  get 'users/new'
  get 'users/edit'

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
