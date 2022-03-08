import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {

  static targets = ["description", "card", "minusButton", "plusButton", "deleteButton", "newButton"]
  connect() {
  }

  minus(event) {
    event.preventDefault();
    event.stopPropagation();

    fetch(this.minusButtonTarget.href, {
      method: 'PATCH',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({quantity: -1})
    })
      .then(response => response.json())
      .then(data => {
        this.element.outerHTML = data.newCardHTML;
        this.updateBasket(-1)
      })
  }

  destroy(event){
    event.preventDefault();
    event.stopPropagation();

    fetch(this.deleteButtonTarget.href, {
      method: 'DELETE',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() }
    })
      .then(response => response.json())
      .then(data => {
        this.element.outerHTML = data.newCardHTML;
        this.updateBasket(-1)
      })

  }

  create(event) {
    event.preventDefault();
    event.stopPropagation();

    fetch(this.newButtonTarget.href, {
      method: 'POST',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() }
    })
      .then(response => response.json())
      .then(data => {
        this.element.outerHTML = data.newCardHTML;
        this.updateBasket(1);
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
        this.element.outerHTML = data.newCardHTML;
        this.updateBasket(1);
      })
  }

  revealDescription() {
    if (this.descriptionTarget.classList.contains('toggle-paragraph') && this.descriptionTarget.scrollHeight > this.descriptionTarget.clientHeight ) {
      this.descriptionTarget.classList.remove('toggle-paragraph');
      this.cardTarget.style.backgroundColor = "#cccccc";
      this.descriptionTarget.style.paddingRight = "75px";
    }
    else {
      this.descriptionTarget.classList.add('toggle-paragraph');
      this.cardTarget.style.backgroundColor = "";
      this.descriptionTarget.style.paddingRight = "10px";
    }
  }

  updateBasket(quantity) {
    const basket = document.getElementById("basket-quantity")
    basket.innerHTML = parseInt(basket.innerHTML) + quantity
  }
}
