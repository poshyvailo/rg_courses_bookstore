# frozen_string_literal: true
FactoryBot.define do
  factory :credit_card do
    card_owner 'Poshik'
    number '1234 1234 1234 1234'
    expiration '12 / 22'
    cvv '222'
  end
end