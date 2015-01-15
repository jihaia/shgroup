Rails.application.routes.draw do

  namespace :api do

    namespace :rest do


      # GUEST ITEMS ============================================
      resources :guests do

        collection do
          get 'authenticate'
          get 'by/:type/:alternate_id'   => 'guests#by',     :constraints => { :alternate_id => /.*/ }
        end

        resources :addresses
        resources :appointments
        resources :campaigns
        resources :comments
        resources :communications
        resources :email_addresses
        resources :experiences
        resources :incidents
        resources :interactions
        resources :itineraries
        resources :payment_cards
        resources :payments
        resources :preferences
        resources :reservation_preferences
        resources :reservations
        resources :subscriptions
        resources :telephones

      end
    end

  end

end
