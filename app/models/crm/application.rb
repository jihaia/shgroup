class Crm::Application < ActiveRecord::Base

  self.table_name  = "shg_application"
  self.primary_key = "shg_application_id"
end