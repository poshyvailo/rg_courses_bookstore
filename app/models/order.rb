class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :credit_card
end
