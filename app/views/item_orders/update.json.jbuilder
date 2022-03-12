json.newCardHTML(
  json.partial!('items/dish_card.html.erb', item: @item_order.item, item_order: @item_order)
)
json.cardId("card-#{@item_order.item.id}")
