Rails.application.routes.draw do

  namespace :api do
    # GUEST MANAGEMENT =======================================
    get 'guests/authenticate'          => 'guests#authenticate',       :constraints => { :alternate_id => /.*/ }
    get 'guests/by/:alternate_id'      => 'guests#by',                 :constraints => { :alternate_id => /.*/ }

    # SUBSCRIPTION MANAGEMENT ================================
    post 'subscriptions'               => 'subscriptions#create'

    # GUEST ITEMS ============================================
    resources :guests do
      resources :payment_details
    end

  end

end
