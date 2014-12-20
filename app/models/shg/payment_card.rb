class Shg::PaymentCards < ActiveRecord::Base

  self.table_name  = 'shg_payment_card'
  self.primary_key = 'shg_payment_card_id'

end