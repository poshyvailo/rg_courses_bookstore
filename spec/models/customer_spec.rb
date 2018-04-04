require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('test_mail@gmail.com').for(:email) }
  it { should allow_value('test.mail@mail.dp.ua').for(:email) }
  it { should allow_value('-@-.ua').for(:email) }
  it { should have_many(:orders) }
  it { should have_many(:reviews) }
end
