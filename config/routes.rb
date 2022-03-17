Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#qrcode'
  resources :tables, only: [:show] do
    resources :items, only: [:index] do
      resources :item_orders, only: [:create]
    end
    resources :item_orders, only: [:update, :destroy]
    get "/ordersummary", to: "orders#show", as: "order_summary"
    get '/checkout', to: 'orders#checkout'
    get '/waiter', to: 'orders#waiter'
    get '/card', to:'orders#card'
    get '/card-success', to:'orders#card_success'
    resources :reviews, only: [:new, :create]
    get '/review', to: 'reviews#new', as: "review"
    get '/review', to: 'reviews#create'
    get '/review/success', to: 'reviews#success'
  end




  # TODO namespace for routing
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
