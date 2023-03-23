import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="debts"
export default class extends Controller {
  static targets = ["query","modal"]
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
  async search_names(event){
    const value = event.target.value
    await fetch (`http://localhost:3000/clients/?query=${value}`, {
        headers: { accept: 'application/json'},
    }).then((response) => response.json()).then(data => {
      data.clients.forEach(element => {
        console.log(element.name)
      });
    })
  }
}