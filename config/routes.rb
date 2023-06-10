Rails.application.routes.draw do
  resources :auxillary_purchases
  resources :purchases
  resources :crates
  resources :payments
  resources :commands
  resources :inventories
  resources :drinks
  resources :reminders
  resources :clients
  resources :debts
  get '/commands/receipt' , to: 'command#receipt'
  get '/static/accounting', to: 'static#accounting'
  get 'static/check', to: 'static#check'
  get 'static/home'
  get 'static/receipt', to: 'static#receipt'
  get 'static/client', to: 'static#client'
  get 'static/transaction_summary'
  get 'static/crates' , to: 'static#crates'
  get 'static/amnt', to: 'static#amount'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#home"
end
