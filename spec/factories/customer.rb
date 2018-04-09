# frozen_string_literal: true
FactoryBot.define do
  factory :customer do
    email { FFaker::Internet.free_email }
    password 'ABC123456abc'
    password_confirmation 'ABC123456abc'
    confirmed_at Time.now

    factory :customer_with_order do
      after(:create) do |customer|
        order = create :order
        order.order_items << create(:order_item)
        order.customer = customer
        order.save(validate: false)
      end
    end
  end
end