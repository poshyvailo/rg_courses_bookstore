# frozen_string_literal: true
FactoryBot.define do
  factory :delivery_method do
    name { 'Express' }
    price '22.9'
    shipping_days '2-7 days'
  end
end