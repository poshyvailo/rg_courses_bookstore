FactoryBot.define do
  factory :coupon do
    name 'SALE'
    discount { FFaker.numerify '#.##' }
    available true

    factory :used_coupon do
      available false
    end
  end
end
