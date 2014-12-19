class Api::GuestsController < Api::SecureController

  swagger_controller :guests, "Guest Management"


  swagger_api :authenticate do |api|
    summary "Authenticates the credentials of an individual guest"
    notes "The authentication action allows a client to validate the credentials of a guest. The guest may be idetified by either an email address or guest number, accompanied by a password."
    Api::SecureController.secure_params(api)
    param :query,   :identifier,    :string,   :required,   "The guest number or email address of the guest"
    param :query,   :password,      :string,   :required,   "The password of the guest"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def authenticate
    puts request.headers['application']

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

end
