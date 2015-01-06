Rails.application.routes.draw do

  namespace :api do

    namespace :rest do


      # SUBSCRIPTION MANAGEMENT ================================
      post 'subscriptions'                  => 'subscriptions#create'

      # GUEST ITEMS ============================================
      resources :guests do

        collection do
          get 'authenticate'
          get 'guests/by/:type/:alternate_id'   => 'guests#by',     :constraints => { :alternate_id => /.*/ }
        end


        resources :payment_cards

      end
    end

  end

end
