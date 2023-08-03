Rails.application.routes.draw do
  root 'white_bread_stores#index'

  get 'users/account'
  get 'users/profileedit' 
  get 'white_bread_stores/own', to: 'white_bread_stores#own'
  
  devise_for :users
  resources :users

  resources :white_bread_stores do
    resources :evaluations, only: [:new, :create, :destroy]
    member do
      post 'favorite', to: 'white_bread_stores#favorite'
      delete 'unfavorite', to: 'white_bread_stores#unfavorite'
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :evaluations
end
