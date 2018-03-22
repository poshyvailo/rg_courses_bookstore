require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to(:credit_card) }
  it { should have_many(:order_items) }
  it { should belong_to(:billing_address) }
  it { should belong_to(:shipping_address) }
end
