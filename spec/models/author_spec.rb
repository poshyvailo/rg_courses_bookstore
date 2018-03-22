require 'rails_helper'

RSpec.describe Author, type: :model do
  it { expect(subject).to have_many(:books_author) }

  it { expect(subject).to validate_presence_of(:firstname) }
  it { expect(subject).to validate_presence_of(:lastname) }

  it { expect(subject).to validate_length_of(:firstname).is_at_most(50) }
  it { expect(subject).to validate_length_of(:lastname).is_at_most(50) }
end
