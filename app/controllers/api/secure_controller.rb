class Api::SecureController < ApplicationController

  before_filter :authenticate_endpoint

  def authenticate_endpoint
    @brand = request.headers["X-Brand"]
    application = Crm::Application.where(application_id: request.headers["X-Endpoint"], token: request.headers["X-Token"]).first
    valid = application ? true : false
    head :forbidden unless valid
  end # def authenticate_user

  def self.secure_params(api)
    api.param :header, "X-Brand",       :string, :required, "The unique brand identifier"
    api.param :header, "X-Endpoint",    :string, :required, "Unique endpoint or application identifier of a registered system"
    api.param :header, "X-Token",       :string, :required, "Secure token for source system"
    api.response :forbidden,     "[Forbidden]      Returned if the source credentials are incorrect"
  end

  def self.guest_params(api)
    api.param :path,    :guest_id,      :string, :required,   "The identifier used to locate a guest. May be email address or a reservation confirmation number"
    api.response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end

  def self.read_result(api, model_name)
    api.property :records,              :array,                 :required,  "An array of payment cards",      items: {:"$ref" => "#{model_name}"}
    api.property :total,                :integer,               :required,  "The total number of payment cards"
  end


  # Fetches an individual guest using the guest number supplied in the request.
  def fetch_guest
    @guest = Crm::Account.where(guest_number: params[:guest_id]).first
    head :not_found unless @guest
  end


end
