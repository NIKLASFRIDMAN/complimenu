# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

CATEGORY_ARRAY = ["Appetizer","Pizza", "Beverage","Dessert","Vegan", "Wine"]

puts "Clearing Items db"
Item.destroy_all
puts "Starting seed"
30.times do |counter|
  food = Faker::Food
  dish = food.dish
  puts dish
  puts "Seeding #{counter} dish"
  item = Item.new(name: dish,
                  description: food.description,
                  category: CATEGORY_ARRAY.sample,
                  price: rand(10.00..100.00).round(2),
                  image_url: URI.open("https://source.unsplash.com/random/?food,#{dish}").base_uri)
  item.save
end
puts "Done seeding items"
