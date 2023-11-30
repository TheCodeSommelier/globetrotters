import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown-lists"
export default class extends Controller {
  static targets = ["icon", "dropdownLists", "list"]

  connect() {
  }

  dropdown() {
    this.listTarget.classList.toggle("d-none")
  }
}
