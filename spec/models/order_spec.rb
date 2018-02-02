require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:completed_date) }
  it { should validate_presence_of(:state) }
  it { should belong_to(:customer) }
  it { should belong_to(:credit_card) }
  it { should have_many(:order_items) }
  it { should have_one(:billing_address) }
  it { should have_one(:shipping_address) }
end
