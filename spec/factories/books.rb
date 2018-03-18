# frozen_string_literal: true
FactoryBot.define do
  factory :book do
    title { FFaker::CheesyLingo.title }
    price { FFaker.numerify '##.##' }
    in_stock { FFaker::Random.rand(1..30) }
    height { FFaker.numerify '#.#0' }
    width { FFaker.numerify '#.#0' }
    depth { FFaker.numerify '#.#0' }
    year { FFaker::Time.date }
    material { FFaker::Lorem.word }
    image { FFaker::Book.cover }
    description { FFaker::CheesyLingo.paragraph 90 }

    transient do
      count_authors 1
      count_categories 1
    end

    before(:create) do |book, evaluator|
      book.authors << build_list(:author, evaluator.count_authors)
      book.categories << build_list(:category, evaluator.count_categories)
    end
    #
    # factory(:soldout_book) { count 0 }
    # factory(:hidden_book) { visible false }
    #
    # factory(:book_with_reviews) do
    #   reviews { build_list :review, 5 }
    # end
  end
end