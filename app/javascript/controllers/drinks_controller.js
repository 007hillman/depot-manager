import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drinks"
export default class extends Controller {
  static targets = ["query"]
  connect() {
  }
  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}
