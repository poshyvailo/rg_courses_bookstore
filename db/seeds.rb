require 'database_cleaner'
require 'csv'

DatabaseCleaner.clean_with(:truncation)

AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

CSV.read(File.expand_path('db/seeds/categories.csv')).each do |category|
  Category.create(title: category[0])
end

CSV.read(File.expand_path('db/seeds/authors.csv')).each do |author|
  Author.create(firstname: author[0],
                lastname: author[1],
                biography: author[2]
  )
end

CSV.read(File.expand_path('db/seeds/books.csv')).each do |book|
  Book.create(title: book[0],
              description: book[1],
              price: book[2],
              material: book[3],
              width: book[4],
              height: book[5],
              depth: book[6],
              year: "#{book[7]}-1-1",
              image: book[8],
              in_stock: rand(0..100),
              categories: Category.order("RANDOM()").limit(rand(1...3)),
              authors: Author.order("RANDOM()").limit(rand(1...3))
  )
end