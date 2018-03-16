# frozen_string_literal: true
FactoryBot.define do
  factory :customer do
    email { FFaker::Internet.free_email }
    password 'ABC123456abc'
    password_confirmation 'ABC123456abc'

    factory :customer_with_order do
      after(:create) do |customer|
        order = create :order_with_items
        order.customer = customer
        order.save
      end
    end
  end
end