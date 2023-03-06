import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drinks"
export default class extends Controller {
  static targets = ["query","name","abbr"]
  connect() {
    this.abbreviate()
  }
  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
  abbreviate(){
    if(this.nameTarget.value !=  null){
      var drink_name = this.nameTarget.value
      var array = drink_name.split(" ")
      if(array.length == 1){
        this.abbrTarget.value = array[0].slice(0,3).toUpperCase() + document.querySelector('#size').value
      } else{
        this.abbrTarget.value = array[0].slice(0,2).toUpperCase() + array[1].slice(0,1).toUpperCase() + document.querySelector('#size').value
      }
    }
  }
}
