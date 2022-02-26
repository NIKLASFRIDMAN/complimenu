Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :items, only: [:index] do
    resources :item_orders, only: [:create]
  end
  resources :item_orders, only: [:destroy]
  get "/add/:id", to: "item_orders#add", as: "add_item"
  get "/decrease/:id", to: "item_orders#decrease", as: "decrease_item"
  get "/ordersummary", to: "orders#show", as: "order_summary"

  # TODO namespace for routing
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
