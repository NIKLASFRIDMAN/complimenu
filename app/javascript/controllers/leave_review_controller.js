import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs";


export default class extends Controller {
  static targets = [ "form" ]
  send(event) {
    event.preventDefault();
    fetch(this.formTarget.action, {
      method: 'POST',
      headers: { 'Accept': 'application/json', 'X-CSRF-Token': csrfToken() },
      body: new FormData(this.formTarget)
    })
     .then(response => response.json())
     .then((data) => {
      //  console.log(data)
       this.formTarget.parentElement.innerHTML = "Thank you for the review!"
     })
  }
}
