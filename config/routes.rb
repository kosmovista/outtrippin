Outtrippin::Application.routes.draw do
  resource 'expert', only: [:create, :show]

  resources 'users', only: [:show, :destroy]
  resources 'user_sessions', only: [:new, :create, :destroy]
  resources 'password_resets', only: [:new, :create, :edit, :update]

  resources 'itineraries', only: [:index, :show, :create, :update] do
    member do
      get 'details'
      get 'finalize'
      put 'publish'
      get 'checkout'
      put 'purchase'
      get 'thankyou'
    end
    resources 'pitches' do
      member do
        put 'winner'
      end
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

  root 'home#index'
end