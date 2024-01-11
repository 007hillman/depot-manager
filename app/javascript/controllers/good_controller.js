import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="good"

export default class extends Controller {
  
  connect() {
  }
  check(event){

  }
  hideCashOut(){
      document.getElementById('cash_out').classList.toggle("hidden")
      flag1 = true
  }
    hideCashIn(){
      document.getElementById('cash_in').classList.toggle("hidden")
      flag2 = true
  }
}
