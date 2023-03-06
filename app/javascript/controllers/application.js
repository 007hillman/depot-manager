import { Application } from "@hotwired/stimulus"
import jQuery from "jquery"
import StimulusSlimSelect from "stimulus-slimselect"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.jQuery = jQuery // <- "select2" will check this
window.$ = jQuery
application.register('slimselect', StimulusSlimSelect)
export { application }
