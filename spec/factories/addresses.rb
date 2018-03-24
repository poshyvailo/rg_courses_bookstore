# frozen_string_literal: true
FactoryBot.define do
  factory :address do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    delivery_address { FFaker::Address.street_address }
    zipcode { FFaker::AddressUS.zip_code }
    phone { FFaker::PhoneNumber.phone_calling_code + FFaker::PhoneNumber.short_phone_number }
    country { FFaker::Address.country_code }
    city { FFaker::Address.city }
  end
end
