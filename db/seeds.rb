# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

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

items = JSON.parse(File.read('db/seeds_items.json'))
items.each do |item|
  Item.create!(item)
  puts "item created"
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
  order_id = Order.order('RANDOM()').first.id
  item_id = Item.order('RANDOM()').first.id
  review = Review.new(item_id: item_id, order_id: order_id, upvote: rand(1..5))
  puts "Seeding #{counter} review"
  review.save!
end
puts "Done seeding reviews"
