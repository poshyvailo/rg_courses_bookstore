
# frozen_string_literal: true
FactoryBot.define do
  factory :author do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    biography { FFaker::CheesyLingo.paragraph 50 }

    # factory :author_with_books do
    #   transient { books_count 15 }
    #
    #   after :create do |author, evaluator|
    #     create_list :book, evaluator.books_count, authors: [author]
    #   end
    # end
  end
end
