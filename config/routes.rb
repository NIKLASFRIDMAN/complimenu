Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :items, only: [:index] do
    resources :item_orders, only: [:create]
  end

  resources :item_orders, only: [:update, :destroy]

  get "/ordersummary", to: "orders#show", as: "order_summary"
  get '/checkout', to: 'orders#checkout'
  get '/waiter', to: 'orders#waiter'

  # TODO namespace for routing
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
