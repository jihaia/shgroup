class Shg::EmailAddress < ActiveRecord::Base

    self.table_name    = "email_address"
    self.primary_key   = "email_address_id"

    belongs_to   :individual
    #belongs_to   :account,         :through => :individual
end