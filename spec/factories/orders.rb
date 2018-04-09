# frozen_string_literal: true
FactoryBot.define do
  to_create { |instance| instance.save(validate: false) }

  factory :order do

    state 'in_progress'
    customer

    trait :with_customer do
      customer
    end

    trait :with_address do
      billing_address { create :address }
      shipping_address { create :address }
    end

    trait :with_delivery_medhod do
      delivery_method { create :delivery_method }
    end

    trait :with_credit_card do
      credit_card { create :credit_card }
    end

    trait :completed_date do
      completed_date { Time.now }
    end

    trait :total_price do
      total_price { FFaker.numerify '##.##' }
    end

    factory :order_address_step do
      with_customer
    end

    factory :order_delivery_step do
      with_customer
      with_address
    end

    factory :order_payment_step do
      with_customer
      with_address
      with_delivery_medhod
    end

    factory :order_confirm_step do
      with_customer
      with_address
      with_delivery_medhod
      with_credit_card

      factory :completed_order do
        completed_date
      end
    end
  end

end