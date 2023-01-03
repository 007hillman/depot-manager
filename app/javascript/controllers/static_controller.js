import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="static"
export default class extends Controller {
  static targets = ["hideButton"]
  connect() {
  }
  toggle_reminder(){
    if(this.hideButtonTarget.innerText == "Hide"){
      this.hideButtonTarget.innerText = "Add Reminder"
    }else{
      this.hideButtonTarget.innerText = "Hide"
    }
  }
}
