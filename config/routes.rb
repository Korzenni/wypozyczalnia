Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  devise_scope :user do
    get "users/company-sign-up", to: "users/registrations#new_company", as: :new_company
    post "users/company-sign-up", to: "users/registrations#create_company", as: :create_company
    get "business/users/new", to: "users/invitations#new", as: :custom_new_user_invitation
    post "business/users", to: "users/invitations#create", as: :custom_create_user_invitation
  end

  namespace :business do
    get "dashboard", to: "dashboard#show", as: :dashboard
    resources :users, only: [:index, :destroy] do
        post "toggle_role", on: :member
    end
    namespace :settings do
      get "hours", to: "settings#hours", as: :hours
    end
    resources :items, only: [:index, :show, :new, :create]
    resources :item_categories, only: [:index, :show, :new, :create]
  end
end
