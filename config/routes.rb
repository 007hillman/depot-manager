Rails.application.routes.draw do
  resources :drinks
  resources :reminders
  resources :clients
  resources :debts
  get 'static/check', to: 'static#check'
  get 'static/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#home"
end
