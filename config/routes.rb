Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :containers
  resources :containers, only: [:create, :update,:show,:destroy,:index] do
    post :update_tools, on: :member
  end
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :databases, only: [:index, :new, :create] do
    member do
      get 'manage'
    end
  end
  root 'databases#index'
end
