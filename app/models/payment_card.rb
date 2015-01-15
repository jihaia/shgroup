class PaymentCard < ActiveRecord::Base

  self.table_name  = 'payment_cards'
  self.primary_key = 'paymentCardId'


end # class PaymentCard
