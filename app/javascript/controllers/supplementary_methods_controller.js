import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="supplementary-methods"
export default class extends Controller {
  connect() {
  }
  async reinitialize_commands(event){

    await fetch (`http://localhost:3000/clients/?query=${value}`, {
        headers: { accept: 'application/json'},
    }).then((response) => response.json()).then(data => {

    })
  }
}
