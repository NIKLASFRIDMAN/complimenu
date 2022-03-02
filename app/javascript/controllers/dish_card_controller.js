import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";

export default class extends Controller {

  static targets = ["description", "card", "minusButton", "plusButton", "deleteButton", "newButton"]
  connect() {
    // console.log(this.element);
    // console.log(this.plusButtonTarget);
    // console.log(this.minusButtonTarget);
    // console.log(this.quantityTarget);
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
      })
  }

  revealDescription() {
    if (this.descriptionTarget.classList.contains('toggle-paragraph') && this.descriptionTarget.scrollHeight > this.descriptionTarget.clientHeight ) {
      this.descriptionTarget.classList.remove('toggle-paragraph');
      this.cardTarget.style.backgroundColor = "#cccccc";
    }
    else {
      this.descriptionTarget.classList.add('toggle-paragraph');
      this.cardTarget.style.backgroundColor = "";
    }
  }
}
