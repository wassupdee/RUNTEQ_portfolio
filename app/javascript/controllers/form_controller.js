import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  submit(event) {
    // フォームを送信
    this.element.requestSubmit(); // Turboを使ってフォームを非同期送信
  }
}
