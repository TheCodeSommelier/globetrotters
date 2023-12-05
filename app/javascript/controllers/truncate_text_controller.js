import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="truncate-text"
export default class extends Controller {
  static targets = ["textToTruncate"]
  connect() {
  }

  truncateText() {
    this.textToTruncateTarget.classList.toggle("text-truncate")
  }
}
