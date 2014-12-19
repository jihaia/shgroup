Rails.application.routes.draw do

  namespace :api do
    # GUEST MANAGEMENT =======================================
    get 'guests/authenticate'          => 'guests#authenticate'
    get 'guests/by/:alternate_id'      => 'guests#by',             :constraints => { :alternate_id => /.*/ }

    # SUBSCRIPTION MANAGEMENT ================================
    post 'subscriptions'               => 'subscriptions#create'
  end

end
