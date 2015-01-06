class Api::Rest::PaymentCardsController < Api::Rest::SecureController

  before_filter :fetch_guest

  swagger_controller :payment_cards, "Payment Cards"

  swagger_api :index do |api|
    summary "Fetches all payment cards for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    type :result
    Api::Rest::SecureController.secure_params(api)
    param :path,    :guest_id,  :string,   :required,   "The unique guest number that identifies a guest."
    response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end

  def index
    recs  = @guest.payment_cards
    total = recs.count
    render json: {records: recs, total: total}
  end

  swagger_api :show do |api|
    summary "Fetches an individual payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    type :result
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.guest_params(api)
    param :path,    :id,        :stirng,   :required,   "The unique payment card identifier."

  end
  def show
    recs  = @guest.payment_cards.where(shg_payment_card_id: params[:id])
    total = recs.count
    render json: {records: recs.first, total: total}
  end

  swagger_api :create do |api|
    summary "Creates a new payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    Api::Rest::SecureController.secure_params(api)
    param :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest. May be email address or a reservation confirmation number"
    response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end
  def create
    puts params
  end

  swagger_api :update do |api|
    summary "Updates an existing payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    Api::Rest::SecureController.secure_params(api)
    param :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest. May be email address or a reservation confirmation number"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def update
    puts params
  end

  swagger_api :destroy do |api|
    summary "Deletes an existing payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    Api::Rest::SecureController.secure_params(api)
    param :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest. May be email address or a reservation confirmation number"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  def destroy
    puts params
  end


  # Swagger Models =================================================================================
  swagger_model :result do |api|
    Api::Rest::SecureController.read_result(api, "PaymentCard")
  end

  swagger_model :PaymentCard do
    description "A PaymentCard Object."
    property :shg_payment_card_id,  :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :shg_account_id,       :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :individual_id,        :string,   :required, "Guests password in plain text"
    property :token,                :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :card_code,            :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :last_four,            :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :reference_name,       :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :is_default,           :integer,  :required, "A unique identifier thay may be either an email address or guest number"
    property :expires_on,           :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :precheck_in,          :integer,  :required, "A unique identifier thay may be either an email address or guest number"
  end

end
