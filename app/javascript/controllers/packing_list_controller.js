import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="packing-list"
export default class extends Controller {
  static targets = ["form", "items"]
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
        console.log(data.inserted_item)

        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        // this.formTarget.outerHTML = data.form
      })
  }
}
