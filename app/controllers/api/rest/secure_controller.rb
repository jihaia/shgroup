class Api::Rest::SecureController < ApplicationController

  before_filter :authenticate_endpoint


  def authenticate_endpoint
    @brand    = request.headers["X-Brand"]
    @endpoint = request.headers["X-Endpoint-Id"]
    endpoint  = Endpoint.where(endpointId: @endpoint, token: request.headers["X-Endpoint-Token"], mode: Rails.env).first
    valid = endpoint ? true : false
    head :forbidden unless valid
  end # def authenticate_user

  def self.secure_params(api)
    api.param :header, "X-Brand",           :string, :required, "The unique brand identifier"
    api.param :header, "X-Endpoint-Id",     :string, :required, "Unique endpoint or application identifier of a registered system"
    api.param :header, "X-Endpoint-Token",  :string, :required, "Secure token for source system"
    api.response :forbidden,     "[Forbidden]      Returned if the source credentials are incorrect"
  end

  def self.guest_params(api)
    api.param :path,    :guest_id,      :string,   :required,   "The unique system guest identifier"
    api.response :not_found,     "[Not Found]      The guest could not be found by supplied identifier"
  end

  def self.paging_params(api)
    api.param      :query,   :page,          :integer,  :optional,   "The page to retrieve"
    api.param      :query,   :limit,         :integer,  :optional,   "The number of rows per page"
    api.param      :query,   :order,         :string,   :optional,   "The name of the property to order the read by"
    api.param_list :query,   :direction,     :string,   :optional,   "The direction of the order", ["ASC", "DESC"]
    api.param      :query,   :skipPaging,    :boolean,  :optional,   "Indicates if paging should not be applied to the request"
  end

  def self.read_result(api, model_name)
    api.property :success,              :boolean,               :required,  "Indicates if the request was successful"
    api.property :records,              :array,                 :required,  "An array of records",      items: {:"$ref" => "#{model_name}"}
    api.property :total,                :integer,               :required,  "The total number of records"
  end

  def self.create_result(api, model_name)
    api.property :success,              :boolean,               :required,  "Indicates if the request is successful or not"
    api.property :records,              :array,                 :required,  "An array of records",      items: {:"$ref" => "#{model_name}"}
    api.property :total,                :integer,               :required,  "The total number of records"
  end


  # Fetches an individual guest using the guest number supplied in the request.
  def fetch_guest
    id = params[:guest_id]

    @guest = Guest.where(guestId: id).first
    head :not_found unless @guest
  end

  def fetch_records(model, opts={})

    page        = get_page_number
    limit       = get_page_size
    total       = model.count
    includes    = Array(opts[:includes])

    if params[:skipPaging] == "true"
      query = model.includes(includes).all
    else
      query = model.includes(includes).limit(limit).offset(limit * page)
    end

    if(params[:order])
      query = query.order(params[:order].to_sym => get_page_direction)
    end

    {
      records: serialize_models(model, query.to_a, includes: includes),
      total: total
    }

  end


  def fetch_assoc(model, assoc, opts={})

    page        = get_page_number
    limit       = get_page_size
    records     = []
    total       = model.send(assoc).count

    if params[:skipPaging] == "true"
      query = model.send(assoc)
    else
      query = model.send(assoc).limit(limit).offset(limit * page)
    end

    if(params[:order])
      query = query.order(params[:order].to_sym => get_page_direction)
    end

    {
      records: serialize_models(model, query.to_a),
      total: total
    }

  end # def fetch_assoc

  def build_assoc(model_instance, assoc_name, params)

    record = model_instance.send(assoc_name).build

    attrs = get_attributes(record.class, params)
    record.assign_attributes(attrs)

    record

  end # def build_assoc


  # Serializes a single or array or models. This accounts for nested/associated models.
  # For each includes defined, the association will be identified as singular or has_many.
  def serialize_models(model_class, result, opts={})

    models   = Array(result)
    includes = Array(opts[:includes])
    results  = []

    models.each do |rec|
      attributes = rec.attributes
      includes.each do |inc|
        assoc = Array(rec.send(inc))
        assoc.each do |as|
          attributes.merge!({inc => as.attributes})
        end
      end
      results << attributes
    end

    result.kind_of?(Array) ? results : results.first

  end # def serialize_models

  def get_page_number
    params[:page].to_i == 0 ? 0 : params[:page].to_i - 1
  end

  def get_page_size
    params[:limit] ? params[:limit].to_i : 20
  end

  def get_page_direction
    params[:direction] == "DESC" ?  :desc : :asc
  end


  def get_attributes(model, params)
    params.reject {|k,v| !model.column_names.include?(k) }
  end

  def set_resource(resource = nil)
    resource ||= resource_class.find(params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end


  def record_not_found(label)
    render json: {success: false, error: "#{label} not found"}, status: 404
  end


end
