class Api::GuestsController < Api::SecureController

  swagger_controller :guests, "Guest Management"


  swagger_api :authenticate do |api|
    summary "Authenticates the credentials of an individual guest"
    notes "The authentication action allows a client to validate the credentials of a guest. The guest may be idetified by either an email address or guest number, accompanied by a password."
    type :Result
    Api::SecureController.secure_params(api)         
    param :query,   :identifier,    :string,        :required,   "The guest number or email address of the guest"
    param :query,   :password,      :string,        :required,   "The password of the guest"
    response :forbidden
    response :not_acceptable
    response :not_found
  end

  def authenticate
   
    render json: {success: true}
  end

  swagger_api :by do |api|
    summary "Fetches a guest number by via an alternate key"
    notes "Identifiers may be either; confirmation number, email address"
    Api::SecureController.secure_params(api)
    param :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest. May be email address or a reservation confirmation number"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def by
    puts params

    render json: {guest_number: params[:alternate_id] }
  end


  # Swagger Models =================================================================================
  swagger_model :Result do
    description "A simple boolean result object indicating the success or failure of the request."
    property :success,     :boolean,  :required, "A simple boolean result indicating the success or failure of the request"
  end

  swagger_model :Credentials do
    description "A credentials object."
    property :identifier,  :string,   :required, "A unique identifier thay may be either an email address or guest number"
    property :password,    :string,   :required, "Guests password in plain text"
  end

end
