import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {

  static targets= ["dates", "start", "end"]

  connect() {

    flatpickr(this.datesTarget, {
      mode: "range",

      onChange: ([start, end]) => {
        if (start && end) {
          this.startTarget.value = start
          this.endTarget.value = end
          const startIcon = document.getElementsByClassName("selected")
          startIcon[0].classList.add("flatpickr-edit")
          const endIcon = document.getElementsByClassName("selected")
          endIcon[1].classList.add("flatpickr-edit")
        }
      },
      dateFormat: "d-m-Y",
    });
  }
}
