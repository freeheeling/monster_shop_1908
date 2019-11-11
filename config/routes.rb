Rails.application.routes.draw do
  get '/', to: 'items#index', as: 'welcome'

  post '/items/:item_id/reviews',     to: 'reviews#create', as: 'item_reviews'
  get '/items/:item_id/reviews/new',  to: 'reviews#new',    as: 'new_item_review'
  get '/reviews/:id/edit',            to: 'reviews#edit',   as: 'edit_review'
  patch '/reviews/:id',               to: 'reviews#update', as: 'review'
  delete '/reviews/:id',              to: 'reviews#destroy'

  get '/items',                             to: 'items#index'
  get '/merchants/:merchant_id/items',      to: 'items#index',  as: 'merchant_items'
  get '/items/:id/edit',                    to: 'items#edit',   as: 'edit_item'
  get '/items/:id',                         to: 'items#show',   as: 'item'
  get '/merchants/:merchant_id/items/new',  to: 'items#new',    as: 'new_merchant_item'
  post '/merchants/:merchant_id/items',     to: 'items#create'
  patch '/items/:id',                       to: 'items#update'
  delete '/items/:id',                      to: 'items#destroy'

  get '/merchants',           to: 'merchants#index'
  post '/merchants',          to: 'merchants#create'
  get '/merchants/new',       to: 'merchants#new',  as: 'new_merchant'
  get '/merchants/:id/edit',  to: 'merchants#edit', as: 'edit_merchant'
  get '/merchants/:id',       to: 'merchants#show', as: 'merchant'
  patch '/merchants/:id',     to: 'merchants#update'
  delete '/merchants/:id',    to: 'merchants#destroy'

  get '/orders/new',  to: 'orders#new',   as: 'new_order'
  get '/orders/:id',  to: 'orders#show',  as: 'order'
  post '/orders',     to: 'orders#create'

  get '/cart',                                  to: 'cart#show'
  post '/cart/:item_id',                        to: 'cart#add_item'
  patch '/cart/:item_id/:increment_decrement',  to: 'cart#increment_decrement'
  delete '/cart',                               to: 'cart#empty'
  delete '/cart/:item_id',                      to: 'cart#remove_item'

  get '/register',                  to: 'users#new'
  get '/profile',                   to: 'users#show'
  get '/profile/edit',              to: 'users#edit_profile'
  get '/profile/edit_password',     to: 'users#edit_password'
  post '/users',                    to: 'users#create'
  patch '/profile/update',          to: 'users#update_profile'
  patch '/profile/update_password', to: 'users#update_password'

  get '/profile/orders',       to: 'user_orders#index'
  get '/profile/orders/:id',   to: 'user_orders#show', as: 'profile_order'
  patch '/profile/orders/:id', to: 'user_orders#update'

  get '/login',     to: 'sessions#login'
  post '/login',    to: 'sessions#create', as: 'login_create'
  delete '/logout', to: 'sessions#logout'

  namespace :admin do
    get '/',                   to: 'dashboard#index'
    patch '/orders/:order_id', to: 'dashboard#update_order_status'

    get '/users',                   to: 'users#index'
    get '/users/:user_id',          to: 'users#show'
    get '/users/:user_id/edit',     to: 'users#edit_profile'
    patch '/users/:user_id',        to: 'users#toggle_enabled'
    patch '/users/:user_id/update', to: 'users#update_profile', as: 'update_user_profile'

    get '/users/:user_id/orders/:order_id',   to: 'user_orders#show',   as: 'user_order'
    patch '/users/:user_id/orders/:order_id', to: 'user_orders#update', as: 'user_order_update'

    get '/merchants/:merchant_id',   to: 'merchants#show', as: 'merchants'
    patch '/merchants/:merchant_id', to: 'merchants#toggle_enabled'
  end

  namespace :merchant do
    get '/',      to: 'dashboard#index',  as: 'dashboard'

    get '/orders/:order_id',                          to: 'orders#show', as: 'orders'
    patch '/orders/:order_id/:item_order_id/fulfill', to: 'orders#update_item'

    get '/items',                                                     to: 'items#index',               as: 'user_items'
    get '/items/new',                                                 to: 'items#new'
    get '/items/:item_id/edit',                                       to: 'items#edit',                as: 'items_edit'
    post '/items',                                                    to: 'items#create'
    patch '/items/:item_id',                                          to: 'items#update',              as: 'items_update'
    patch '/items/:item_id/activate_deactivate/:activate_deactivate', to: 'items#activate_deactivate', as: 'items_activate_deactivate'
    patch '/items/disable/:item_id',                                  to: 'items#disable_item',        as: 'item_disable'
  end
end
