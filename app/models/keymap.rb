class Keymap < ActiveRecord::Base

  self.table_name  = 'keymaps'
  self.primary_key = 'keymapId'

  belongs_to :guest

end
