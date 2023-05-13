Rails.application.routes.draw do

  scope module: :public do
    get 'orders/complete' => 'orders#complete', as: 'complete'
    post 'orders/confirm_information' => 'orders#confirm_information', as: 'confirm_information'
    post 'orders/confirm_order' => 'orders#confirm_order', as: 'confirm_order'
    resources :orders, only: [:new, :show, :index]
  end
  scope module: :public do
    get '/' => 'homes#top'
    get 'homes/about'
  end
  scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    delete 'cart_items/destroy/:id' => 'cart_items#destroy', as: 'destroy_cart_item'
    resources :cart_items, only: [:index, :update, :create]
  end

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    get 'customers/:id/confirm_withdraw' => 'customers#confirm_withdraw', as: 'confirm_withdraw'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :customers, only: [:show, :edit, :update]
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  namespace :admin do
    get '/' => 'homes#top'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end