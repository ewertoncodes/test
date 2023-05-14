# frozen_string_literal: true

Rails.application.routes.draw do
  root 'residents#new'
  resources :residents
  resources :search, only: [:index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
