Rails.application.routes.draw do
  root 'pages#home'


  devise_for :users
  devise_scope :user do
    get "users/company-sign-up", to: "users/registrations#new_company", as: :new_company
    post "users/company-sign-up", to: "users/registrations#create_company", as: :create_company
  end
end
