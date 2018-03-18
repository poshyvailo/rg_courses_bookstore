# frozen_string_literal: true
FactoryBot.define do
  to_create { |instance| instance.save(validate: false) }

  factory :order do

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

    trait :order_step_address do
      order_step 'address'
    end

    trait :order_step_delivery do
      order_step 'delivery'
    end

    trait :order_step_payment do
      order_step 'payment'
    end

    factory :order_address_step, traits: [:with_customer]
    factory :order_delivery_step, traits: [:with_customer,
                                           :with_address,
                                           :order_step_address]
    factory :order_payment_step, traits: [:with_customer,
                                          :with_address,
                                          :with_delivery_medhod,
                                          :order_step_delivery]
    factory :order_confirm_step, traits: [:with_customer,
                                          :with_address,
                                          :with_delivery_medhod,
                                          :with_credit_card,
                                          :order_step_payment]

  end

end