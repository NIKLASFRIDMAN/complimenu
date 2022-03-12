import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";
import consumer from "../channels/consumer";

export default class extends Controller {

  static targets = ["items",  "description", "card", "minusButton", "plusButton", "deleteButton", "newButton"]
  connect() {
    console.log("Hello from stimulus");
    const itemsDiv = this.element;
    const tableroomId = itemsDiv.dataset.tableroomId;
    console.log(itemsDiv);
    console.log(tableroomId)
    consumer.subscriptions.create(
      { channel: 'TableroomChannel', table_id: tableroomId },
      {
        // when you receive something
        received(response) {
          // update the DOM
          const data = JSON.parse(response);
          console.log(data)
          const card = document.getElementById(data.cardId);
          card.outerHTML = data.newCardHTML;
          console.log(card);
        }
      }
    )
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
        // card.outerHTML = data.newCardHTML;
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
