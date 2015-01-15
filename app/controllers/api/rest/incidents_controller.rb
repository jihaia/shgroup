class Api::Rest::IncidentsController < Api::Rest::SecureController

  before_filter :fetch_guest

  swagger_controller :incidents, "Incidents"

  swagger_api :index do |api|
    summary "Fetches all incidents for a guest"
    notes "Incidents"
    type :Incidents
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.guest_params(api)
    Api::Rest::SecureController.paging_params(api)
  end

  def index
    render json: fetch_assoc(@guest, :incidents)
  end

  swagger_api :show do |api|
    summary "Fetches an individual incident for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    type :Incidents
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.guest_params(api)
    param :path,    :id,        :string,   :required,   "The reference code of the incident"

  end
  def show
    recs  = @guest.incidents.where(referenceCode: params[:id])
    total = recs.count
    render json: {records: recs.first, total: total}
  end

  swagger_api :create do |api|
    summary "Creates a new incident for a guest"
    notes ""
    type :Incidents
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.guest_params(api)
    param :body,    :body,  :NewIncident,   :required,   "Incident Object"
    response 500, "Error occured creating the record", 'ErrorResult'
  end

  def create
    record = build_assoc(@guest, :incidents, params[:incident])
    if(record.save)
      render json: {success: true, records: [record], total: 1}
    else
      render json: {success: false, errors: record.errors}
    end
  end # def create

  swagger_api :update do |api|
    summary "Updates an existing payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    type :Incidents
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.guest_params(api)
    param :path,    :id,        :string,     :required,   "The reference code of the incident"
    param :body,    :body,      :Incident,   :required,   "Incident Object"
    response 500, "Error occured creating the record", 'ErrorResult'
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def update
    record  = @guest.incidents.where(referenceCode: params[:id]).first
    if record
      record.assign_attributes(params[:incident])
      if(record.save)
        render json: {success: true, records: [record], total: 1}
      else
        render json: {success: false, errors: record.errors}
      end
    else
      record_not_found("incident")
    end
  end

  swagger_api :destroy do |api|
    summary "Deletes an existing payment card for a guest"
    notes "Identifiers may be either; confirmation number, email address"
    Api::Rest::SecureController.secure_params(api)
    Api::Rest::SecureController.guest_params(api)
    param :path,    :id,        :string,   :required,   "The reference code of the incident"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  def destroy

    record = @guest.incidents.where(referenceCode: params[:id]).first
    if record
      record.destroy
      render json: {success: true}
    else
      record_not_found("incident")
    end
  end


  # Swagger Models =================================================================================
  swagger_model :Incidents do |api|
    Api::Rest::SecureController.read_result(api, "Incident")
  end


  swagger_model :NewIncident do
    description "An Incident Object."

    property :propertyNumber,    :string,      :optional, "Unique property number defined for each physical porperty"
    property :incidentType,      :string,      :required, "Represents the type of incident reported"
    property :problemArea,       :string,      :optional, "A further classification to the incident type"
    property :description,       :text,        :required, "A detailed discription of the incident"
    property :status,            :string,      :required, "Represents the current status of the incident"
    property :startedOn,         :date,        :optional, "The date the incident began (as reported by the guest)"
    property :reportedOn,        :date,        :required, "The date the incident was reported in the system"
    property :resolvedOn,        :date,        :optional, "The date the incident status was set to closed"
    property :assignedTo,        :string,      :optional, "The username or group the incident is assigned to"
  end

  swagger_model :Incident do
    description "An Incident Object."

    property :referenceCode,     :string,      :required, "Unique reference code created for each incident"
    property :guestId,           :string,      :required, "Unique identifier for a guest"
    property :propertyNumber,    :string,      :optional, "Unique property number defined for each physical porperty"
    property :incidentType,      :string,      :required, "Represents the type of incident reported"
    property :problemArea,       :string,      :optional, "A further classification to the incident type"
    property :description,       :text,        :required, "A detailed discription of the incident"
    property :status,            :string,      :required, "Represents the current status of the incident"
    property :startedOn,         :date,        :optional, "The date the incident began (as reported by the guest)"
    property :reportedOn,        :date,        :required, "The date the incident was reported in the system"
    property :resolvedOn,        :date,        :optional, "The date the incident status was set to closed"
    property :assignedTo,        :string,      :optional, "The username or group the incident is assigned to"
  end


end
