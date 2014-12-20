class Shg::Account < ActiveRecord::Base

  self.table_name  = :shg_account
  self.primary_key = :shg_account_id

end