import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("keypress",(ev)=>{
      if(ev.code == "Enter"){
        ev.preventDefault()
        document.querySelector("#submit").click()
      }
    })
  }
  show_menu(){
    var item = document.querySelector('#menu_div')
    item.classList.toggle("hidden")
  }
  up(e){
    e.preventDefault()
    var quantity_field = e.target.parentElement.parentElement.querySelector("#quantity")
    quantity_field.value = parseInt(quantity_field.value, 10) + 1
  }
  down(e){
    e.preventDefault()
    var quantity_field = e.target.parentElement.parentElement.querySelector("#quantity")
    quantity_field.value = parseInt(quantity_field.value, 10) - 1
  }
}
