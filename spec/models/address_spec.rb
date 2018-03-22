require 'rails_helper'

RSpec.describe Address, type: :model do
  it { expect(subject).to validate_presence_of(:firstname) }
  it { expect(subject).to validate_presence_of(:lastname) }
  it { expect(subject).to validate_presence_of(:delivery_address) }
  it { expect(subject).to validate_presence_of(:zipcode) }
  it { expect(subject).to validate_presence_of(:city) }
  it { expect(subject).to validate_presence_of(:country) }
  it { expect(subject).to validate_presence_of(:phone) }

  it { expect(subject).to validate_length_of(:firstname).is_at_most(50) }
  it { expect(subject).to validate_length_of(:lastname).is_at_most(50) }
  it { expect(subject).to validate_length_of(:delivery_address).is_at_most(50) }
  it { expect(subject).to validate_length_of(:city).is_at_most(50) }
  it { expect(subject).to validate_length_of(:zipcode).is_at_most(10) }
end
