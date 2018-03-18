# frozen_string_literal: true
FactoryBot.define do
  factory :address do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    delivery_address { FFaker::Address.street_address }
    zipcode { FFaker::AddressUS.zip_code }
    phone { '380991111111' }
    country { FFaker::Address.country_code }
    city { FFaker::Address.city }
  end
end
