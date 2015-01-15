class Person < ActiveRecord::Base

  self.table_name  = :people
  self.primary_key = :emailAddress

  # ASSOCIATIONS ============================================
  has_many  :guests,             foreign_key: :emailAddress

  has_many  :addresses,          foreign_key: :emailAddress


  # VALIDATIONS =============================================
  validates :firstName,    presence: true
  validates :lastName,     presence: true
  validates :emailAddress, presence: true

end # class Person
