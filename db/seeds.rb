# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'

#categories = ['Web Dev', 'Mobile Dev', 'Networks', 'Desktop Dev', 'iOS', 'Low-level programming']

#categories.each do |cat|
#  Category.create(name: cat)
#end
puts "Starting seeds..."

5.times do
  Category.create(name: FFaker::Book.genre)
end

puts "Categories created..."
puts "Creating Autors..."
50.times do
  Author.create(name: FFaker::Book.author)
end

puts "Authors created..."
puts "Creating Books..."
i = 1
100.times do
  b = Book.create!(
      name: FFaker::Book.title,
      price: rand(1.0..99.00).round(2),
      short_desc: FFaker::Book.description(1),
      category: Category.find(rand(1..5)),
      info_book: InfoBook.new(
          full_desc: FFaker::Book.description(rand(2..5)),
          quantity: rand(1..3),
          width: rand(100..250),
          height: rand(100..250),
          depth: rand(10..250),
          materials: FFaker::CheesyLingo.words(rand(1..3)).join(', '),
          published: rand(1950..2017)
        )
    )

  b.images << Image.new(remote_image_url: FFaker::Book.cover)

  rand(1..5).times do
    a = {}
    loop do
      a = Author.find(rand(1..50))
      break unless b.authors.include?(a)
    end
    b.authors << a
  end
  puts "Book ##{i} created"
  i += 1
end
puts "Books created"
puts "SUCCESS"
