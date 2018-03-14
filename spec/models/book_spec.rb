require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it { should validate_presence_of(:in_stock) }
  it do
    should validate_numericality_of(:in_stock).is_greater_than_or_equal_to(0)
  end
  it { should have_many(:books_author) }
  it { should have_many(:books_category) }
  it { should have_many(:rating) }
end
