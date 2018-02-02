require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should validate_presence_of(:text_review) }
  it { should validate_presence_of(:rating_number) }
  it { should belong_to(:book) }
  it { should belong_to(:customer) }
end
