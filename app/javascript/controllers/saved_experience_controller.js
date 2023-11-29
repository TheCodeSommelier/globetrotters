import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="saved-experience"
export default class extends Controller {
  static targets = ["form", "button"]
  connect() {
  }

  dropdown() {
    this.formTarget.classList.toggle("d-none")
  }
}
