class Api::PaymentCardsController < Api::SecureController

  swagger_controller :payment_cards, "Guest Payment Cards"

  swagger_api :index do |api|
    summary "Fetches a guest number by via an alternate key"
    notes "Identifiers may be either; confirmation number, email address"
    Api::SecureController.secure_params(api)
    param :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest. May be email address or a reservation confirmation number"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  def index
    puts params
  end

end