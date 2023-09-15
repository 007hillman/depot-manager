import { Controller } from "@hotwired/stimulus"
var array = []

// Connects to data-controller="command"
export default class extends Controller {
static targets = ["itemRow", "template", "items", "query"]
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
  async search_client(event){
    const value = event.target.value
    const list = document.querySelector("#result")
    list.innerHTML = ""
    await fetch (`http://localhost:3000/commands/?query=${value}`, {
        headers: { accept: 'application/json'},
    }).then((response) => response.json()).then((data)=>{
      data.commands.forEach(command => {
        let item = document.createElement('li')
        item.innerText =command.client_name
        item.setAttribute("data-action","click->command#select")
        list.appendChild(item)
      });
    })
  }
  select(event){
    const nom = event.target.innerText
    document.querySelector("#search_field").value = nom
    const list = document.querySelector("#result")
    list.innerHTML = ""
    document.querySelector("#search_field").focus()
  }
  async check_stock(event){
    var selected_id = event.target.value
    await fetch (`http://localhost:3000/commands/?check=${selected_id}`, {
        headers: { accept: 'application/json'},
    }).then((response) => response.json()).then((data)=>{
      var fin = event.target.closest(".item-field").querySelector("#display")
      fin.innerText = "IN STOCK : " + data.commands.crates + data.commands.packaging + " ; " + data.commands.bottles + "bottles"
    })
  }
  }
