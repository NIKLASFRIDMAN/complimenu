import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";
import consumer from "../channels/consumer";

export default class extends Controller {

  static targets = ["minusButton", "plusButton", "deleteButton", "card"]
  connect() {
   const tableroomId = this.element.dataset.tableroomId;
    const price = document.getElementById("total-price");
    consumer.subscriptions.create(
      { channel: 'TableroomChannel', table_id: tableroomId },
      {
        // when you receive something
        received(response) {
          // update the DOM
          const data = JSON.parse(response);
          const card = document.getElementById(data.cardId)
          if (data.orderCardHTML) {
            card.outerHTML = data.orderCardHTML;
          }
          else {
            card.outerHTML = "";
          }

          let totalPrice = 0;
          document.querySelectorAll(".item-order-price").forEach(element => {
            totalPrice += parseFloat(element.innerText)
          })     
          price.innerHTML = `<strong>` + `${totalPrice}`.match(/(\d+\.\d{2})/)[0] + ` €</strong>`
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
  }

  destroy(event) {
    event.preventDefault();
    event.stopPropagation();

    fetch(this.deleteButtonTarget.href, {
      method: 'DELETE',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() }
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
  }
}
