Rails.application.routes.draw do

  get 'friendships/create'
  get 'friendships/destroy'
  get 'friendships/index'
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :friendships, only: [:create, :destroy, :index, :update]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users#new_guest'
    post 'users/guest_admin_sign_in', to: 'users#new_admin_guest'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
