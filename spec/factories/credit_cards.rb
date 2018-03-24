# frozen_string_literal: true
FactoryBot.define do
  factory :credit_card do
    card_owner { FFaker::Name.name }
    number FFaker.numerify '################'
    expiration { FFaker::Time.between(Time.now, 10.year.from_now) }
    cvv FFaker.numerify '###'
  end
end