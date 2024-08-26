import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "previewContainer"]

  preview() {
    let input = this.inputTarget;
    let previewContainer = this.previewContainerTarget;

    // プレビューコンテナをクリア
    previewContainer.innerHTML = "";

    // すべてのファイルをループで処理
    Array.from(input.files).forEach(file => {
      let reader = new FileReader();

      reader.onloadend = function() {
        // 新しい画像要素を作成してプレビューコンテナに追加
        let img = document.createElement("img");
        img.src = reader.result;
        img.style.width = "100px";
        // img.style.marginRight = "10px";
        previewContainer.appendChild(img);
      };

      if(file) {
        reader.readAsDataURL(file);
      }
    });
  }
}
