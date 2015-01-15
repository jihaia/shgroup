class Incident < ActiveRecord::Base

  self.table_name  = :incidents
  self.primary_key = :referenceCode

  # ASSOCIATIONS ============================================
  belongs_to :guest,             foreign_key: :guestId

  has_many   :keymaps
  has_many   :addresses,         through: :person
  has_many   :email_addresses,   through: :person
  has_many   :payment_cards


  # DEFAULTS ================================================
  before_validation :default_referenceCode
  before_validation :default_reportedOn
  before_validation :default_status
  before_validation :default_incidentType

  def default_referenceCode
    self.referenceCode ||= Sequence.nextval "INCIDENT_REF_CODE"
  end

  def default_reportedOn
    self.reportedOn ||= Time.now
  end

  def default_status
    self.status ||= "NEW"
  end

  def default_incidentType
    self.incidentType = "ISSUE"
  end

  # VALIDATIONS =============================================
  validates :guest,          presence: true
  validates :reportedOn,     presence: true
  validates :status,         presence: true
  validates :description,    presence: true


end # class Incident
