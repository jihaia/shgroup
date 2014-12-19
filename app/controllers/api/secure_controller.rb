class Api::SecureController < ApplicationController

  before_filter :authenticate_endpoint

  def authenticate_endpoint
  	@brand = request.headers["brand"]
	application = Shg::Application.where(application_id: request.headers["application"]).where(token: request.headers["token"]).first
	valid = application ? true : false
    head :forbidden unless valid
  end # def authenticate_user

  def self.secure_params(api)
    api.param :header, "brand",       :string, :required, "The unique brand identifier"
    api.param :header, "application", :string, :required, "Unique application identifier for source system"
    api.param :header, "token",       :string, :required, "Secure token for source system"
  end


end
