import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown-lists"
export default class extends Controller {
  static targets = ["icon", "dropdownLists", "list"]

  connect() {
    console.log("Hello from controller!")
  }

  dropdown() {
    this.listTarget.classList.toggle("d-none")
  }
}
