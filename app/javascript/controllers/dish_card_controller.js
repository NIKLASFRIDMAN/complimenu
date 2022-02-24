import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["description", "card"]
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
