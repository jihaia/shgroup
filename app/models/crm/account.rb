class Crm::Account < ActiveRecord::Base

  self.table_name  = :shg_account
  self.primary_key = :shg_account_id

  belongs_to :individual
  has_many   :payment_cards,   :through => :individual  

end