Rails.application.routes.draw do
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
  get '/customers/:id' => 'public/customers#show', as: 'customer'
  get '/customers/:id/edit' => 'public/customers#edit', as: 'edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end