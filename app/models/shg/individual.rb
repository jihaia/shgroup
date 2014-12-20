class Shg::Individual < ActiveRecord::Base

  self.table_name  = :individual
  self.primary_key = :individual_id

  has_one   :account

  has_many  :email_addresses

end