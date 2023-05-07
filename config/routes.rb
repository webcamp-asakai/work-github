Rails.application.routes.draw do
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  scope module: :public do
    get 'items' => 'items#index'
    get 'items/:id' => 'items#show', as: 'item'
  end
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  namespace :admin do
    get '/' => 'homes#top'
  end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    resources :customers, only: [:show, :edit, :update]
    get 'customers/:id/confirm_withdraw' => 'customers#confirm_withdraw', as: 'confirm_withdraw'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end