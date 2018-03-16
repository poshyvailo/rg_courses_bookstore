# frozen_string_literal: true
FactoryBot.define do
  to_create { |instance| instance.save(validate: false) }

  factory :order do
    factory :order_with_items do
      transient do
        items_count 3
      end

      after(:create) do |order, evaluator|
        build_list(:order_item, evaluator.items_count, order: order ).each do |item|
          order.order_items << item
        end
      end
    end
  end
end