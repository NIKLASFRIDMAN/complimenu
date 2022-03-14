json.newCardHTML(
  json.partial!('items/dish_card.html.erb', item: @item_order.item, item_order: @item_order)
)
json.cardId("card-#{@item_order.item.id}")
json.quantity(@quantity)

json.orderCardHTML(
  json.partial!('orders/order_card.html.erb', table: @table, item_order: @item_order)
)
