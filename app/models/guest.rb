class Guest < ActiveRecord::Base

  self.table_name  = 'guests'
  self.primary_key = 'guestId'

  has_many :keymaps

end
