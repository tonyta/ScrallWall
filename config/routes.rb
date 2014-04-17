ProjectBernies::Application.routes.draw do
  root 'home#index'


  resources :pictures, only: [:new, :create, :update]

  resources :artifacts , only:[:new, :create, :show, :index] do
    collection do
      get 'explore'
    end
  end

  resources :artifacts do
    put "upvote", :to => "artifacts#upvote", as: :upvote
    put "downvote", :to => "artifacts#downvote", as: :downvote
  end

  patch 'artifacts/:artifact_id', to: 'artifacts#update'
  patch 'artifacts/:artifact_id/pictures/:picture_id', to: 'pictures#update', as: 'artifact_picture'
  get 'pictures/neighbors', to: 'pictures#neighbors', constraints: {format: 'json'}
  get 'neighborhoods/find', to: 'neighborhoods#find', constraints: {format: 'json'}
  get 'neighborhoods', to: 'neighborhoods#all', constraints: {format: 'json'}
  get 'neighborhoods/:id', to: 'neighborhoods#show', as: 'neighborhood'
end
