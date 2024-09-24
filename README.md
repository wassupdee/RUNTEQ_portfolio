# Stay Friends
## アプリのURL
https://powerful-sands-04341-a27c5520cc0b.herokuapp.com/

## サービス概要
このアプリは、しばらく連絡を取らずに疎遠になってしまった「むかし仲が良かった友だち」と、再びつながることをサポートするサービスです。  

大きく３つの機能を提供します。
1. **３つの質問に答えるだけで、友だちに送る最適なメッセージを提案します。**  
久しぶりに連絡を取りたいと思っても、長く連絡を取っていない友だちに何て送ればよいか、メッセージに頭を悩ませる人も多いと思います。  
そんなユーザーのペインを、AIが最適なメッセージを提案することで、解消します。

2. **友だちの誕生日が近づくとLINE通知を受け取れます。**  
友だちの誕生日や大切な日をアプリに登録後、その日が近づくとLINEにリマインド通知を受け取ることができます。  
お祝いメッセージを忘れずに送れるので、友だちとつながり続けることができます。

3. **友だちとの思い出を、写真や日記で記録できます**  
アプリに登録した友だちごとにアルバムをつくり、写真や日記を記録できます。  
思い出を可視化することで、友だちとの心のつながりを支えます。

## このサービスへの思い・作りたい理由
私は、高校・大学で海外留学をし、その時に様々な国籍の友だちができました。  
しかし、帰国後時間が経つにつれ、連絡を取り合うことも少なくなり、いつの間にか疎遠になってしまいました。  

同じように、社会人になってからは地元を離れて就職したため、地元で一緒に育った友だちとも連絡を取り合うことは少なくなりました。

せっかくできた友だちとの関係が切れてしまうのは本当に残念なことだと感じ、再び友だちと連絡を取り合い、関係が続く社会をつくれたらと思い、このサービスを企画・開発しました。

私だけでなく、世の中の多くの人も、卒業・就職・引っ越しなどで同じような経験をしているのではないかと思います。このサービスが、誰かの役に立つのであれば幸いです。

## ユーザー層について
- 進学や就職で地元をしばらく離れている人
- 社会人3～10年目の人

日本は、多くの人が進学・就職で地方から東京などの大都市に転居します。  
そのような人たちは、地元の友だちとの連絡も少なくなり、疎遠になってしまった人も多いのではないかと思います。

また、社会人3～10年目は、結婚や出産等で新しい人生のフェーズに入る人も多い年代です。  
家族と過ごす時間が増え、友だちとの時間が減ってしまうことで、同様の課題を抱えているのではないかと想定しています。

## サービスの利用イメージ
1. ユーザーは、「久しぶりに連絡を取りたい友だち」を頭に思い浮かべた後、３つの簡単な質問に答えます。AIから最適なメッセージ文が提案されるので、それをコピーしメッセージアプリ（LINE等）のメッセージ入力欄に貼り付けて、友だちに送信します。

2. ユーザーは、当アプリの連絡帳に、友だちのプロフィール情報（名前、電話番号、誕生日等）を登録します。通知設定画面にて、「誕生日の〇日前に通知」と設定すると、その日に自分のLINEにリマインド通知が届きます。これにより、忘れずに友だちにお祝いメッセージを送ることができます。

3. ユーザーは、当アプリのアルバムに、友だちとの思い出写真や日記を記録します。友だちとの思い出を振り返ることで、友だちとの絆を深めます。

## ユーザーの獲得について

- mattermost、Fledge HubでのRUNTEQ生（社会人3～10年目が多く在籍）への発信
- SNSでの情報拡散
- qiita記事作成


## サービスの差別化ポイント・推しポイント

当アプリの機能を個別にもつサービスは存在するが、  
それらを複合的に組み合わせ、「疎遠になってしまった友だちとの連絡を再開し、関係継続を支援する」ことに特化したサービスは他にないと考えます。

### 差別化ポイント
- ３つの簡単な質問に答えるだけで、AIからメッセージ内容を提案してくれる。
- 友だちの誕生日をユーザー自身で登録でき、その日が近くなるとLINE通知を受け取ることができる。
- 友だちとの思い出を、写真や日記で記録できる。

### 推しポイント
- AIから提案されたメッセージをその場で自分好みに編集できる。
- AIから提案されたメッセージは、ワンクリックでコピーができるので、簡単にメッセージアプリに貼り付けて送信できる。
- 各連絡先に設定されたLINE通知は、マイページから一括でOFFできる。
- 誕生日・大切な日が今月の友だちは、連絡帳ページのバナーに表示される。
- 「大切な日」のタイトルを自由に変更できる（例：「大切な日」→「卒業記念日」）
- 最後に連絡した日を、友だちごとに記録できる（例：「1年前」、「3年前」など）

## 機能一覧
### 基本機能
  - トップページ
  - 会員登録・ログイン
  - パスワードリセット
  - LINEログイン

### AIメッセージ
  - AIによるメッセージ提案
  - メッセージコピー

### 連絡帳
  - 一覧
    - マルチ検索
    - バナー通知
  - 詳細（プロフィール情報）
    - アルバム（画像保存）
    - LINE通知設定

## 使用技術

| カテゴリー | 仕様技術 |
| - | - |
| フロントエンド | TailwindCSS<br>daisyUI<br>JavaScript<br>Hotwire |
| バックエンド | Ruby 3.2.3<br>Ruby on Rails 7.1.3.4|
| インフラ | Heroku<br>Amazon S3 |
| データベース | MySQL |
| API | OpenAI API<br>LINE Messaging API<br>LINE Login API |
| CI | GitHubActions |
| 開発環境 | Docker |
| テスト | RSpec<br>Capybara<br>rubocop |

## 画面遷移図
Figma：https://www.figma.com/design/lFd2OYHDfzMORIIZEBwt0Q/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3%E3%80%80%E6%B8%85%E6%9B%B8?node-id=38-1881&t=8kibtZcWwFSQPAt8-0

## ER図
dbdiagram.io: https://dbdiagram.io/d/668898e59939893dae2eedaf
[![Image from Gyazo](https://i.gyazo.com/bc2e89e4e57afaca9f65166f2a1ac8ad.png)](https://gyazo.com/bc2e89e4e57afaca9f65166f2a1ac8ad)