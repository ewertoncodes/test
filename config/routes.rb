# frozen_string_literal: true

Rails.application.routes.draw do
  root 'residents#new'
  resources :residents do
    member do
      patch 'update_status'
    end
  end
  resources :search, only: [:index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
