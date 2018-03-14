require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { should validate_presence_of(:card_owner) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:cvv) }
  it { should validate_presence_of(:expiration) }
end
