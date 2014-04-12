ProjectBernies::Application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users do
    resources :reflections, only:[:new, :create, :destroy]
    resources :pictures, only:[:new, :create, :destroy]
  end

  resources :pictures, only: [:new, :create, :update]

  resources :sessions, only: [:new, :create, :destroy]

  resources :artifacts , only:[:new, :create, :show, :index] do
    collection do
      get 'explore'
    end
  end

  get 'artihash', to: 'artifacts#artihash', as: 'artihash'

  patch 'artifacts/:artifact_id/pictures/:picture_id', to: 'pictures#update', as: 'artifact_picture'

  resources :locations, only:[:new, :create, :show, :index ]

  namespace :admin do
    # resources :posts, :comments, :artifacts, :reflections, :pictures
  end
end
