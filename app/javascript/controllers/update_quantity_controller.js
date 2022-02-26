import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['quantity', 'button'];
  connect() {
    console.log(this.buttonTarget)
  }
  calculate(event) {
    event.preventDefault();
    console.log(this.buttonTarget)
    fetch(this.buttonTarget.action)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      });
  }
}
