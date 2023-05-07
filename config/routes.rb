Rails.application.routes.draw do

  scope module: :public do
    get '/' => 'homes#top'
    get 'homes/about'
  end
  scope module: :public do
    resources :cart_items, only: [:index, :new, :update, :destroy, :create]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    resources :customers, only: [:show, :edit, :update]
    get 'customers/:id/confirm_withdraw' => 'customers#confirm_withdraw', as: 'confirm_withdraw'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
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