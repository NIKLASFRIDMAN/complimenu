import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["description"]

  revealDescription() {
    this.descriptionTarget.style.removeProperty('display', '-webkit-line-clamp', '-webkit-box-orient', 'overflow','text-overflow');
    this.descriptionTarget.classList.remove('text-hidden')
    console.log(this.descriptionTarget)
  }
}
