// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("DOMContentLoaded", function() {
  const form = document.querySelector("#ai_questions");
  form.addEventListener("submit", function(event) {
    // チェックボックスの選択状況を確認する
    const checkboxes = form.querySelectorAll('input[type="checkbox"]');
    if (checkboxes.length === 0) {
      return;
    }

    const isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
    if (!isChecked) {
      alert("少なくとも1つ選択してください。");
      event.preventDefault(); // フォーム送信をキャンセル
    }
  });
});

document.querySelector('[data-dismiss-target="#sticky-banner"]').addEventListener('click', function() {
  var banner = document.getElementById('sticky-banner');
  if (banner) {
      banner.style.display = 'none';
  }
});