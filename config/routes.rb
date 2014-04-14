ProjectBernies::Application.routes.draw do
  root 'home#index'

  resources :pictures, only: [:new, :create, :update]

  resources :artifacts , only:[:new, :create, :show, :index] do
    collection do
      get 'explore'
    end
  end

  patch 'artifacts/:artifact_id/pictures/:picture_id', to: 'pictures#update', as: 'artifact_picture'
  get 'pictures/neighbors', to: 'pictures#neighbors', constraints: {format: 'json'}
end
