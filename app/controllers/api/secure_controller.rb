class Api::SecureController < ApplicationController

  before_filter :authenticate_endpoint

  def authenticate_endpoint
    @brand = request.headers["X-Brand"]
    application = Shg::Application.where(application_id: request.headers["X-Application"]).where(token: request.headers["X-Token"]).first
    valid = application ? true : false
    head :forbidden unless valid
  end # def authenticate_user

  def self.secure_params(api)
    api.param :header, "X-Brand",       :string, :required, "The unique brand identifier"
    api.param :header, "X-EndPoint",    :string, :required, "Unique endpoint or application identifier of a registered system"
    api.param :header, "X-Token",       :string, :required, "Secure token for source system"
    api.response :forbidden,     "[Forbidden]      Returned if the source credentials are incorrect"
  end


  # Fetches an individual guest using the guest number supplied in the request.
  def fetch_guest
    @guest = Shg::Account.where(guest_number: params[:guest_id]).first
    head :not_found unless @guest
  end


end
