import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['quantity', 'button'];

  connect() {
    console.log(this.element);
    console.log(this.quantityTarget);
    console.log(this.buttonTarget);
  }
}
