require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should validate_presence_of(:delivery_address) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:country) }
end
