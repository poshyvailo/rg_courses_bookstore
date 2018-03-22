require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:book_one) { create(:book, title: "A", price: 1) }
  let!(:book_two) { create(:book, title: "B", price: 2) }
  let!(:book_three) { create(:book, title: "C", price: 3) }
  let!(:book_four) { create(:book, title: "D", price: 4) }
  let!(:book_five) { create(:book, title: "E", price: 5) }

  let!(:normal) { [book_one, book_two, book_three, book_four, book_five] }

  it { expect(subject).to have_many(:books_author) }
  it { expect(subject).to have_many(:books_category) }
  it { expect(subject).to have_many(:rating) }
  
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:in_stock) }

  it { expect(subject).to validate_numericality_of(:price).is_greater_than(0) }
  it { expect(subject).to validate_numericality_of(:height).is_greater_than(0) }
  it { expect(subject).to validate_numericality_of(:width).is_greater_than(0) }
  it { expect(subject).to validate_numericality_of(:depth).is_greater_than(0) }

  it { expect(subject).to validate_numericality_of(:in_stock).is_greater_than_or_equal_to(0) }
end
