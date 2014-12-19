class Api::SecureController < ApplicationController

  def self.secure_params(api)
    api.param :header, "brand",       :string, :required, "The unique brand identifier"
    api.param :header, "application", :string, :required, "Unique application identifier for source system"
    api.param :header, "token",       :string, :required, "Secure token for source system"
  end


end
