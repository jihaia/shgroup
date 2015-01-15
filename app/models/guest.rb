class Guest < ActiveRecord::Base

  self.table_name  = :guests
  self.primary_key = :guestId

  # ASSOCIATIONS ============================================
  belongs_to :person,            foreign_key: :emailAddress

  has_many   :keymaps
  has_many   :addresses,         through: :person
  has_many   :email_addresses,   through: :person
  has_many   :payment_cards
  has_many   :incidents,         foreign_key: :guestId


  # DEFAULTS ================================================
  before_create :default_id

  def default_id
    self.guestId = Sequence.nextval "GUEST_ID"
  end

  # VALIDATIONS =============================================
  validates :emailAddress, uniqueness: {scope: :brand}
  validates :brand, presence: true
  validates :person, presence: true


end # class Guest
