import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {

  static targets= ["dates", "start", "end"]

  connect() {
    console.log(this.datesTarget)
    console.log(this.startTarget)
    console.log(this.endTarget)

    flatpickr(this.datesTarget, {
      mode: "range",
      onChange: ([start, end]) => {
        if (start && end) {
          this.startTarget.value = start
          this.endTarget.value = end
        }
      },
      dateFormat: "d-m-Y",
    });
  }
}
