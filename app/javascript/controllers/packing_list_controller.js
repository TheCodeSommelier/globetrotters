import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="packing-list"
export default class extends Controller {
  static targets = ["form", "items", "packingItem"]
  static values = {
    journey: String
  }

  connect() {
    console.log("List controller hello!")
  }

  send(event) {
    event.preventDefault()
    fetch(this.formTarget.action, {
      method: "PATCH",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        // this.formTarget.outerHTML = data.form
      })
  }

  delete(event) {
    console.log(event.target.classList)
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const packingItemToRemove = document.querySelector("." + event.target.classList[0])
    this.itemsTarget.removeChild(packingItemToRemove)
    console.log(this.journeyValue)

    fetch(`/journeys/${this.journeyValue}/delete_packing_item`, {
      method: "PATCH",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      body: JSON.stringify({ packingItem: event.target.classList[1] })
    });
  }
}
