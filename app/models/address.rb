class Address < ActiveRecord::Base

  self.table_name    = "addresses"
  self.primary_key   = "addressId"

  # ASSOCIATIONS ============================================
  belongs_to   :person,         foreign_key: :emailAddress

end # class Address
