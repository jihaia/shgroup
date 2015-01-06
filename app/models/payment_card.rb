class PaymentCard < ActiveRecord::Base

  self.table_name  = 'shg_payment_card'
  self.primary_key = 'shg_payment_card_id'

  belongs_to :account
  belongs_to :individual

end
