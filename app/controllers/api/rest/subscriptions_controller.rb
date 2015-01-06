class Api::Rest::SubscriptionsController < ApplicationController

  swagger_controller :subscriptions, "Subscription Management"

=begin
  swagger_api :create do
    summary "Creates a new subscription to one or more interests for a guest or anonymous contact."
    notes "Identifiers may be either; confirmation number, email address or guest ID"
    param :header, :brand, :integer, :optional, "The Brand Identifier"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
=end

  def create
  end

end
