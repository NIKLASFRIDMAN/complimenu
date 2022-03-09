import consumer from "./consumer";


const initChatroomCable = () => {
  const itemsContainer = document.getElementById('items');
  console.log(itemsContainer);
  if (itemsContainer) {
    const id = itemsContainer.dataset.itemId;
    console.log(id)

    consumer.subscriptions.create({ channel: "TableroomChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
      },
    });
  }
}
export { initChatroomCable };
