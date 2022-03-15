import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";
import consumer from "../channels/consumer";

export default class extends Controller {

  static targets = ["minusButton", "plusButton", "deleteButton", "card"]
  connect() {
   const tableroomId = this.element.dataset.tableroomId;
   const card = this.cardTarget
    consumer.subscriptions.create(
      { channel: 'TableroomChannel', table_id: tableroomId },
      {
        // when you receive something
        received(response) {
          // update the DOM
          const data = JSON.parse(response);
          console.log(card)
          card.outerHTML = data.orderCardHTML;
        }
      }
    )
  }
  minus(event) {
    event.preventDefault();
    event.stopPropagation();

    fetch(this.minusButtonTarget.href, {
      method: 'PATCH',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ quantity: -1 })
    })
      .then(response => response.json())
      .then(data => {
        this.element.outerHTML = data.orderCardHTML;
        this.updatePrice();
      })
  }

  destroy(event) {
    event.preventDefault();
    event.stopPropagation();

    fetch(this.deleteButtonTarget.href, {
      method: 'DELETE',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() }
    })
      .then(response => response.json())
      .then(data => {
        this.element.remove();
        this.updatePrice();
      })

  }

  plus(event) {
    event.preventDefault();
    event.stopPropagation();

    fetch(this.plusButtonTarget.href, {
      method: 'PATCH',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ quantity: 1 })
    })
      // .then(response => response.json())
      // .then(data => {
      //   this.element.outerHTML = data.orderCardHTML;
      //   this.updatePrice();
      // })
  }

  updatePrice() {
    const price = document.getElementById("total-price");
    let totalPrice = 0;
    document.querySelectorAll(".item-order-price").forEach(element => {
      totalPrice += parseFloat(element.innerText)
    })
    price.innerHTML = `${totalPrice} €`
  }
}
