json.newCardHTML(
  json.partial!('items/dish_card.html.erb', item: @item, item_order: nil)
)
json.cardId("card-#{@item.id}")
json.quantity(@quantity);
