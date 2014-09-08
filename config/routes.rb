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
      post 'toggle_star'
      put 'email_sharer'
    end
    resources 'pitches' do
      member do
        put 'winner'
        put 'remove'
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

        put 'booking', action: 'add_booking'
        put 'booking/:booking_id', action: 'add_picture_booking'
        post 'booking/:booking_id', action: 'update_booking'
        delete 'booking/:booking_id', action: 'delete_booking'


        put 'picture', action: 'add_picture'
        delete 'picture/:picture_id', action: 'delete_picture'

        post 'ready', action: 'ready_for_review'
      end
    end
  end

  get     'login'     => 'user_sessions#new'
  delete  'logout'    => 'user_sessions#destroy'
  get     'register'  => 'experts#new'
  get     'home'      => 'home#index'
  get     'browse'    => 'application#browsexperimental'
  get     'browsexperimental'    => 'application#browsexperimental'
  get     'uikit'    => 'application#uikit'

  namespace :admin do
    get ''  => 'dashboard#index', as: '/'
    get 'expert_list' => 'dashboard#expert_list'
    resources 'itineraries' do
      post 'toggle_published'
    end

    resources 'places' do
      post 'remove_pitch'
    end

    resources 'plans' do
      post 'toggle_published'
      post 'toggle_featured'
    end
  end



  # API ###########################################################
  namespace :api do
    namespace :v1 do
      resources :stories
#      resource :user_sessions, only: :create
      resources :plans, only: [:index]
    end
  end
  #################################################################



  get "/delayed_job" => DelayedJobWeb, anchor: false

  root 'home#index'
end