import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "source", "copy_button" ]

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value)
    this.copy_buttonTarget.innerHTML = '<button type="button"></button> コピーしました！'
  }
}
