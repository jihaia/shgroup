class Endpoint < ActiveRecord::Base

  self.table_name  = 'endpoints'
  self.primary_key = 'endpointId'

end
