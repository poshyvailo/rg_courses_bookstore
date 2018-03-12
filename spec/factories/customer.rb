# frozen_string_literal: true
FactoryBot.define do
  factory :customer do
    email FFaker::Internet.free_email
    password '12345678'
    password_confirmation '12345678'
  end
end