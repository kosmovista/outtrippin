Outtrippin::Application.routes.draw do
  resource 'expert', only: [:create, :show]

  resources 'users', only: [:show, :destroy]
  resources 'user_sessions', only: [:new, :create, :destroy]
  resources 'itineraries', only: [:index, :show, :create, :update] do
    member do
      get 'details'
      get 'finalize'
      put 'publish'
    end
  end

  get     'login'     => 'user_sessions#new'
  delete  'logout'    => 'user_sessions#destroy'
  get     'register'  => 'experts#new'
  get     'home'      => 'home#index'

  namespace :admin do
    get ''  => 'dashboard#index', as: '/'
    resources 'itineraries'
  end

#  root 'home#index'
  root 'experts#new'
end