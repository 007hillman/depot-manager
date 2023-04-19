Rails.application.routes.draw do
  resources :crates
  resources :payments
  resources :commands
  resources :inventories
  resources :drinks
  resources :reminders
  resources :clients
  resources :debts
  get '/commands/receipt' , to: 'command#receipt'
  get 'static/check', to: 'static#check'
  get 'static/home'
  get 'static/receipt', to: 'static#receipt'

  get 'static/transaction_summary'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#home"
end
