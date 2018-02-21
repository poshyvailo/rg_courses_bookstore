# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

10.times { Category.create(title: FFaker::Book.genre) }

10.times do
  Author.create(
      firstname: FFaker::Name.first_name,
      lastname: FFaker::Name.last_name,
      biography: FFaker::Lorem.paragraph)
end

10.times do
  Book.create(
          title: FFaker::Book.title,
          description: FFaker::Book.description,
          price: rand(0.0...100.0),
          in_stock: rand(0...100),
          height: rand(15...50),
          width: rand(15...50),
          depth: rand(15...50)
  )
end