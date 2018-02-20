# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

10.times { Category.create(title: "#{FFaker::Book.genre}") }

10.times do
  firstname = FFaker::Name.first_name
  lastname = FFaker::Name.last_name
  biography = FFaker::Lorem.paragraph
  Author.create(firstname: firstname, lastname: lastname, biography: biography)
end

10.times do
  title = FFaker::Book.title
  description = FFaker::Book.description
  price = rand(0.0...100.0)
  in_stock = rand(0...100)
  category_id = Category.all.sample.id
  author_id = Author.all.sample.id
  Book.create(
          title: title,
          description: description,
          price: price,
          in_stock: in_stock,
          category_id: category_id,
          author_id: author_id
  )
end