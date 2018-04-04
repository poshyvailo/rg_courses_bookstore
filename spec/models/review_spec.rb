require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should validate_presence_of(:text_review) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:rating_number) }
  it do
    should validate_numericality_of(:rating_number)
               .is_greater_than_or_equal_to(1)
               .is_less_than_or_equal_to(5)
  end
  it { should belong_to(:book) }
  it { should belong_to(:customer) }
end
