class Property < ActiveRecord::Base

  self.table_name  = 'properties'
  self.primary_key = 'propertyNumber'

end # class Property
