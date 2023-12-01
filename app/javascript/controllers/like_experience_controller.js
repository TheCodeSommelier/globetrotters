import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like-experience"
export default class extends Controller {
  static targets = ["total", "likes", "heart"]

  static values = { id: String }

  connect() {

  }

  updateLikes(event) {
    event.preventDefault()
    console.log(this.idValue)
    const url = `experiences/${this.idValue}/like`
    fetch(url, {
      method: "GET",
      headers: { "Accept": "text/plain" }
    })
    .then(response => response.text())
    .then((data) => {
      this.likesTarget.innerHTML = data
    })
  }

}
