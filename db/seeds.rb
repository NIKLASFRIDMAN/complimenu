# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "i18n"

CATEGORY_ARRAY = ["Appetizer","Pizza", "Beverage","Dessert","Vegan", "Wine"]

puts "Clearing table table"
Table.destroy_all

5.times do |counter|
  table = Table.new
  table.save!
  puts "Seeding #{counter} table"
end
puts "Done with tables table"

puts "Clearing orders db"
Order.destroy_all
3.times do |counter|
  order = Order.new
  order.table = Table.order('RANDOM()').first
  puts "Seeding #{counter} order"
  order.save!
end
puts "Done seeding orders"

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
                  image_url: URI.open("https://source.unsplash.com/random/?food,#{I18n.transliterate(dish)}").base_uri)
  item.save
end
puts "Done seeding items"

puts "Clearing item_orders db"
ItemOrder.destroy_all
20.times do |counter|
  order_id = Order.order('RANDOM()').first.id
  item_id = Item.order('RANDOM()').first.id
  quantity = rand(1..10)
  item_order = ItemOrder.new(order_id: order_id, item_id: item_id, quantity: quantity)
  puts "Seeding #{counter} item_order"
  item_order.save!
end
puts "Done seeding item_orders"

Review.destroy_all
50.times do |counter|
  review = Review.new(item_id: rand(1..30), order_id: rand(1..3), upvote: rand(1..5))
  puts "Seeding #{counter} item_order"
  review.save!
end
puts "Done seeding reviews"
