//HotwireStimulusから、コントローラー機能を読み込む（手元にもってくる）
import { Controller } from "@hotwired/stimulus"

//クラスを作り、コントローラー機能を継承する。また、当クラスを他のファイルがimportできるようにする。
export default class extends Controller {
  // コントローラーがアクセスする要素を宣言
  static targets = ["input", "previewContainer"]

  // アクションを定義
  preview() {
    //要素を取得する
    let input = this.inputTarget; //クラス内のインスタンス（this）の内、targetに入っている"input"要素を取得する
    let previewContainer = this.previewContainerTarget; //同上

    // プレビューコンテナをクリア
    previewContainer.innerHTML = "";

    // input要素のファイルを配列に入れ、一つずつ取り出し、fileという変数に入れる
    Array.from(input.files).forEach(file => {
      //readerという変数にファイルを読み取る機能を入れる
      let reader = new FileReader();

      //ファイルの読み込みが終わった時、以下の処理を実行する
      reader.onloadend = function() {
        // img要素を生成し、imgに代入。document=当該HTMLのDOM
        let img = document.createElement("img");
        // ファイルの読み込み結果を、img要素のsrcに入れる
        img.src = reader.result;
        // 幅を指定する
        img.style.width = "100px";
        // previewContainer要素に上から順番に差し込む
        previewContainer.appendChild(img);
      };

      //ファイルのURLを読み込む（非同期で行われ、完了後、上記のonloadend内の処理が始まる）
      //onloadは先に定義するのがベストプラクティス
      if(file) {
        reader.readAsDataURL(file);
      }
    });
  }
}
