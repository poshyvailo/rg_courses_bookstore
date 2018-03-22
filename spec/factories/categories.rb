# frozen_string_literal: true
FactoryBot.define do
  factory :category do
    title { FFaker::Book.genre }
  end
end