class Api::Rest::AddressesController < Api::Rest::SecureController


  before_filter :fetch_guest

  swagger_controller :addresses, "Addresses"

  swagger_api :index do |api|
    summary "Fetches all addresses for a guest"
    notes "Addresses represent a physical location that the guest has an affinity too. Guests may have zero or more addresses with no upper limit."
    type :result
    Api::Rest::SecureController.secure_params(api)
    param :path,    :guest_id,  :string,   :required,   "The unique guest number that identifies a guest."
    response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end

  def index
    render json: fetch_assoc(@guest, :addresses)
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
    Api::Rest::SecureController.read_result(api, "Address")
  end

  swagger_model :Address do
    description "An Address domain object."
    property :addressId,            :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :guestId,              :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :addressType,          :string,   :optional, "Guests password in plain text"
    property :line1,                :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :line2,                :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :line3,                :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :line4,                :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :city,                 :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :stateProvince,        :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :countryCode,          :string,   :optional, "A unique identifier thay may be either an email address or guest number"
    property :isPrimary,            :boolean,  :required, "A unique identifier thay may be either an email address or guest number"
    property :revisionNumber,       :integer,  :required, "A unique identifier thay may be either an email address or guest number"
  end

end
