import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="debts"
export default class extends Controller {
  static targets = ["query","modal","mod2"]
  connect() {
    
  }
  submit(){
    const value = this.queryTarget.value 
    fetch(`/?query=${value}`, {
      headers: { accept: 'application/json'}
    })
  }
  show_modal(event){
    event.preventDefault()
    this.modalTarget.classList.toggle("hidden")
  }
  hide_modal(event){
    event.preventDefault()
    this.modalTarget.classList.toggle("hidden")
  }
  show_mod2(event){
    event.preventDefault()
    this.mod2Target.classList.toggle("hidden")
  }
  hide_mod2(event){
    event.preventDefault()
    this.mod2Target.classList.toggle("hidden")
  }
  async search_names(event){
    const value = event.target.value
    const list = document.querySelector("#result")
    list.innerHTML = ""
    await fetch (`http://localhost:3000/clients/?query=${value}`, {
        headers: { accept: 'application/json'},
    }).then((response) => response.json()).then(data => {
      data.clients.forEach(client => {
        let item = document.createElement('li')
        item.innerText =client.name
        item.setAttribute("data-action","click->debts#select")
        list.appendChild(item)
      });
    })
  }
  select(event){
    const nom = event.target.innerText
    document.querySelector("#name_field").value = nom
    const list = document.querySelector("#result")
    list.innerHTML = ""
  }
}