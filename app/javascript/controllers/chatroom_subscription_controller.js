import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number, userId: Number }
  static targets = ["messages"]

  connect() {
    console.log(this.userIdValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue, receiver_id: this.userIdValue },
      { received: (data) => {
        this.#insertMessageAndScrollDown(data.html)
      } }
    )
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }

  #insertMessageAndScrollDown(data) {
    console.log('marco ')

    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  resetForm(event) {
    console.log('marco ')
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
