Rails.application.routes.draw do

  get '/',  to:'photos#index'

  resources :photos do
    collection do
      get  'favorite'
      post 'confirm'
    end
  end
  resources :favorites,only: [:create,:destroy]
  resources :sessions, only: [:new,:create, :destroy]
  resources :users

end
