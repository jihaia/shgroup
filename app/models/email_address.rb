class EmailAddress < ActiveRecord::Base

  self.table_name    = "email_addresses"
  self.primary_key   = "addressId"

  # ASSOCIATIONS ============================================
  belongs_to   :person,           foriegn_key: :emailAddress

end # class EmailAddress
