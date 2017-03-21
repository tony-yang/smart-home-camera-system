Rails.application.routes.draw do
  root 'home#index'
  get 'home/login'
  post 'home/attempt_login'
  get 'home/logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
