require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { should validate_presence_of(:card_owner) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:cvv) }
  it { should validate_presence_of(:expiration) }

  it { expect(subject).to validate_length_of(:card_owner).is_at_most(50) }
  it { expect(subject).to validate_length_of(:number).is_equal_to(16) }
  it { expect(subject).to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
end
