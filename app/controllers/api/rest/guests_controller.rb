class Api::Rest::GuestsController < Api::Rest::SecureController

  swagger_controller :guests, "Guest Management"


  swagger_api :authenticate do |api|
    summary "Authenticates the credentials of an individual guest"
    notes "The authentication action allows a client to validate the credentials of a guest. The guest may be idetified by either an email address or guest number, accompanied by a password."
    type :Result
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
    summary "Fetches a guest number by via an alternate key"
    notes "Identifiers may be either; confirmation number, email address"
    Api::Rest::SecureController.secure_params(api)
    param_list :path,    :type,          :string,   :required,   "Type", [ "email_address", "reservation_id", "guest_number", "telephone_number" ]
    param      :path,    :alternate_id,  :string,   :required,   "The identifier used to locate a guest."
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