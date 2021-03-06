class Order < ApplicationRecord
  belongs_to :buyer
  belongs_to :product
  belongs_to :billing, optional: true

  enum status: [:onbascket, :notpaid, :paid, :cancel]


end
