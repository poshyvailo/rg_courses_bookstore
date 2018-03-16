# frozen_string_literal: true
FactoryBot.define do
  factory :category do
    title { FFaker::CheesyLingo.title }
  end
end