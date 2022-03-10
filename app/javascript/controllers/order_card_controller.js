import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {

  static targets = ["minusButton", "plusButton", "deleteButton"]

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
      .then(response => response.json())
      .then(data => {
        this.element.outerHTML = data.orderCardHTML;
        this.updatePrice();
      })
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
