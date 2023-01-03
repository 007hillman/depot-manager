import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="debts"
export default class extends Controller {
  static targets = ["query"]
  connect() {
  }
  submit(){
    const value = this.queryTarget.value 
    fetch(`/?query=${value}`, {
      headers: { accept: 'application/json'}
    })
  }
}
