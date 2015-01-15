class Api::Rest::GuestsController < Api::Rest::SecureController

  swagger_controller :guests, "Guest Management"
  before_filter :fetch_guest, only: [:destroy, :show, :update]


  swagger_api :authenticate do |api|
    summary "Authenticates the credentials of an individual guest"
    notes "The authentication action allows a client to validate the credentials of a guest. The guest may be idetified by either an email address or guest number, accompanied by a password."
    type :SuccessResult
    Api::Rest::SecureController.secure_params(api)
    param :query,   :identifier,    :string,        :required,   "The guest number or email address of the guest"
    param :query,   :password,      :string,        :required,   "The password of the guest"
    response :unauthorized,  "[Unauthorized]   Indicates the user was found but the password is incorrect"
    response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end

  def authenticate
    status, valid = 404, false

    # find as email_address
    email_address = EmailAddress.where(address: params[:identifier]).first
    if email_address && email_address.individual && email_address.individual.account
      status = 401
      if (email_address.individual.account.password == params[:password])
        status, valid = 200, true
      end
    else
      # fetch as guest number
      account = Account.where(guest_number: params[:identifier]).first
      if account
        status = 401
        if account.password == params[:password]
          status, valid = 200, true
        end
      end
    end

    render json: {success: valid}, status: status
  end


  swagger_api :by do |api|
    summary "Fetches a guest number using an alternate key"
    notes "Identifiers may be either; confirmation number, email address or telephone number"
    Api::Rest::SecureController.secure_params(api)
    param_list :path,    :type,          :string,   :required,   "Type", [ "email_address", "reservation_id", "guest_number", "telephone_number" ]
    param      :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest."
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def by

    puts params
    render json: {guestId: params[:alternate_id] }

  end


  swagger_api :index do |api|
    summary "Fetches all guests"
    notes "Addresses represent a physical location that the guest has an affinity too. Guests may have zero or more addresses with no upper limit."
    type :IndexResult
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.paging_params(api)
    response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end

  def index
    render json: fetch_records(Guest, includes: :person)
  end


  swagger_api :show do |api|
    summary "Fetches an individual payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    type :result
    Api::Rest::SecureController.secure_params(api)
    param :path,    :id,        :stirng,   :required,   "The unique guest identifier"

  end

  def show
    render json: serialize_models(Guest, @guest, includes: :person)
  end


  swagger_api :create do |api|
    summary "Creates a guest account"
    notes <<-NOTES
    A guest account is a unique person for a single brand. A guest is uniquely
    identified by an email address.
      NOTES
    type :CreateResult
    Api::Rest::SecureController.secure_params(api)
    param :body,    :body,  :Guest,   :required,   "Guest Object"
    response 500, "Error occured creating the record", 'ErrorResult'
  end

  def create

    record = Guest.new(get_attributes(Guest, params[:guest]))
    record.brand = @brand
    if(record.save)
      if(params[:alternateId])
        puts "CREATING KEYMAP", @endpoint, params[:alternateId]
      end

      render json: {success: true, records: [record], total: 1}
    else
      render json: {success: false, errors: record.errors}
    end

  end

  swagger_api :update do |api|
    summary "Updates a guest"
    notes "A guest is indentified by a guestId. Note that any of the personal attributes updated on the guest will update the related person. The person is shared between guests."
    Api::Rest::SecureController.secure_params(api)
    param :path,    :id,       :string,          :required,   "The unique guestId of the guest to update"
    param :body,    :body,     :Guest,           :required,   "Guest Object"
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
  swagger_model :SuccessResult do
    description "A simple boolean result object indicating the success or failure of the request."
    property :success,     :boolean,  :required, "A simple boolean result indicating the success or failure of the request"
  end

  swagger_model :ErrorResult do
    description "An error occurred creating the record"
    property :success,     :boolean,  :required, "A simple boolean result indicating the success or failure of the request"
    property :errors,      :string,   :optional, "Array of errors"
  end

  swagger_model :Result do
    description "A simple boolean result object indicating the success or failure of the request."
    property :success,     :boolean,  :required, "A simple boolean result indicating the success or failure of the request"
  end

  swagger_model :CreateResult do |api|
    Api::Rest::SecureController.create_result(api, "Guest")
  end

  swagger_model :IndexResult do |api|
    Api::Rest::SecureController.read_result(api, "Guest")
  end

  swagger_model :Guest do
    description "A unique consumer entity for a given brand."
    property :guestId,             :string,   :optional,      "The unique guest number auto-generated for each guest in the system"
    property :emailAddress,        :string,   :required,      "The unique email address for the guest"
    property :alternateId,         :string,   :optional,      "The alternate identified of a guest from an external system. The external system will be determined by from the X-Endpoint property of the header."
    property :brand,               :string,   :optional,      "Guests password in plain text"
    property :firstName,           :string,   :required,      "Guests password in plain text"
    property :lastName,            :string,   :required,      "Guests password in plain text"
    property :languageCode,        :string,   :optional,      "Guests password in plain text"
    property :bornOn,              :date,     :optional,      "Guests password in plain text"
    property :birthMonth,          :integer,  :optional,      "Guests password in plain text"
    property :birthDay,            :integer,  :optional,      "Guests password in plain text"
    property :anniversaryMonth,    :integer,  :optional,      "Guests password in plain text"
    property :anniversaryDay,      :integer,  :optional,      "Guests password in plain text"
    property :currency,            :string,   :optional,      "Guests password in plain text"
    property :lastStayOn,          :date,     :optional,      "Guests password in plain text"
    property :lastStayProperty,    :string,   :optional,      "Guests password in plain text"
    property :lastCommunicationOn, :string,   :optional,      "Guests password in plain text"
    property :lifetimeValue,       :integer,  :optional,      "Guests password in plain text"
    property :revisionNumber,      :integer,  :optional,      "Guests password in plain text"
  end

end
