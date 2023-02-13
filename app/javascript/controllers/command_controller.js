import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="command"
export default class extends Controller {
static targets = ["itemRow", "template", "items"]
  connect() {
  }
  
  deleteRow(event){
  	event.preventDefault()
  	
    let item = event.target.closest(".item-field")
    item.querySelector("input[name*='_destroy']").value = 1 
    item.style.display = 'none'
  }
  addItem(event){
  	event.preventDefault()
  	var content = this.itemRowTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().getTime())
  	this.itemsTarget.insertAdjacentHTML('beforebegin',content)
  }
}
