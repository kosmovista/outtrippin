Outtrippin::Application.routes.draw do
  resource 'expert', only: [:create, :show]

  resources 'users', only: [:show, :destroy, :edit, :update] do
    put 'update_avatar'
  end
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
    resource 'plan' do
      member do
        put 'day', action: 'add_day'
        post 'day/:day_id', action: 'update_day'
        delete 'day/:day_id', action: 'delete_day'

        put 'tip_trick', action: 'add_tip_trick'
        post 'tip_trick/:tip_trick_id', action: 'update_tip_trick'
        delete 'tip_trick/:tip_trick_id', action: 'delete_tip_trick'

        put 'picture', action: 'add_picture'
        delete 'picture/:picture_id', action: 'delete_picture'
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

  get "/delayed_job" => DelayedJobWeb, anchor: false

  root 'home#index'
end