import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";
import consumer from "../channels/consumer";

export default class extends Controller {

  static targets = ["items",  "description", "card", "minusButton", "plusButton", "deleteButton", "newButton"]
  connect() {
  }

  minus(event) {
    event.preventDefault();
    event.stopPropagation();
    const btn = event.currentTarget
    const card = document.getElementById(`card-${btn.id}`);
    fetch(btn.href, {
      method: 'PATCH',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ quantity: 1 })
    })
      .then(response => response.json())
      .then(data => {
        card.outerHTML = data.newCardHTML;
        this.updateBasket(-1);
      })
  }

  destroy(event){
    event.preventDefault();
    event.stopPropagation();
    const btn = event.currentTarget
    const card = document.getElementById(`card-${btn.id}`);
    fetch(btn.href, {
      method: 'DELETE',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ quantity: 1 })
    })
      .then(response => response.json())
      .then(data => {
        card.outerHTML = data.newCardHTML;
        this.updateBasket(-1);
      })
  }

  create(event) {
    event.preventDefault();
    event.stopPropagation();
    const btn = event.currentTarget
    const card = document.getElementById(`card-${btn.id}`);
    fetch(btn.href, {
      method: 'POST',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ quantity: 1 })
    })
      .then(response => response.json())
      .then(data => {
        card.outerHTML = data.newCardHTML;
        this.updateBasket(1);
      })
  }

  plus(event) {
    event.preventDefault();
    event.stopPropagation();
    const btn = event.currentTarget
    const card = document.getElementById(`card-${btn.id}`);
    fetch(btn.href, {
      method: 'PATCH',
      headers: { 'Accept': "application/json", 'X-CSRF-Token': csrfToken() },
      body: JSON.stringify({ quantity: 1 })
    })
      .then(response => response.json())
      .then(data => {
        card.outerHTML = data.newCardHTML;
        this.updateBasket(1);
      })
  }

  revealDescription({params}) {
    const id = params.id;
    const card = document.getElementById(`card-description-${id}`);
    if (card.classList.contains('toggle-paragraph') && card.scrollHeight > card.clientHeight ) {
      card.classList.remove('toggle-paragraph');
      card.style.backgroundColor = "#cccccc";
      card.style.paddingRight = "75px";
    }
    else {
      card.classList.add('toggle-paragraph');
      card.style.backgroundColor = "";
      card.style.paddingRight = "10px";
    }
  }

  updateBasket(quantity) {
    const basket = document.getElementById("basket-quantity")
    basket.innerHTML = parseInt(basket.innerHTML) + quantity
  }
}
