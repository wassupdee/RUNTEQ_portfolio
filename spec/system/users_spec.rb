require "rails_helper"

RSpec.describe "users", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザーの新規作成が成功する" do
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録が完了しました"
          expect(page).to have_current_path(root_path)
        end
      end

      context "名前が256文字以上" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "名前", with: "テ" * 256
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
        end
      end

      context "登録済のメールアドレスを使用" do
        it "ユーザーの新規作成が失敗する" do
          existed_user = create(:user)
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: existed_user.email
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: "password"
          click_button "登録"
          expect(page).to have_content "このメールアドレスはすでに存在します"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
          expect(page).to have_field "名前", with: "テスト"
          expect(page).to have_field "メールアドレス", with: existed_user.email
        end
      end

      context "パスワードが2文字以下" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "ab"
          fill_in "パスワード再入力", with: "ab"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
        end
      end

      context "パスワードが空欄" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: ""
          fill_in "パスワード再入力", with: ""
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
        end
      end

      context "確認用パスワードが空欄" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード再入力", with: ""
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
        end
      end

      context "パスワードと確認用パスワードが一致しない" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_path
          fill_in "名前", with: "テスト"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "パスワード", with: "password_1"
          fill_in "パスワード再入力", with: "password_2"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_current_path(new_user_path)
        end
      end
    end

    describe "パスワードリセット" do
      context "正常な入力値" do
        it "パスワードを変更できる" do
          visit login_path
          click_link "パスワードを忘れましたか？"
          fill_in "email", with: user.email
          click_button "申請"
          sleep 1

          # 送信されたメールを取得
          email = ActionMailer::Base.deliveries.last

          # メール本文からURLを抽出（正規表現でhrefのリンクを取得）
          require "base64"
          email_body = email.html_part.body.decoded
          reset_url = email_body.match(/href="([^"]+)"/)[1]

          # パスワードリセットフォームに遷移
          visit reset_url
          fill_in "新しいパスワード", with: "new_password"
          fill_in "パスワード再入力", with: "new_password"
          click_button "変更"
          expect(page).to have_content "パスワードがリセットされました"
          expect(page).to have_current_path(login_path)
        end
      end

      context "未登録のメールアドレス" do
        it "パスワードを変更できない" do
          visit login_path
          click_link "パスワードを忘れましたか？"
          fill_in "email", with: "unregistered@example.com"
          click_button "申請"
          sleep 1

          expect(page).to have_content("パスワードリセットのメールを送信しました")

          # 送信されたメールを取得
          email = ActionMailer::Base.deliveries.last
          expect(email).to eq nil
        end
      end

      context "パスワードが2文字以下" do
        it "パスワードを変更できない" do
          visit login_path
          click_link "パスワードを忘れましたか？"
          fill_in "email", with: user.email
          click_button "申請"
          sleep 1

          # 送信されたメールを取得
          email = ActionMailer::Base.deliveries.last

          # メール本文からURLを抽出（正規表現でhrefのリンクを取得）
          require "base64"
          email_body = email.html_part.body.decoded
          reset_url = email_body.match(/href="([^"]+)"/)[1]

          # パスワードリセットフォームに遷移
          visit reset_url
          fill_in "新しいパスワード", with: "ab"
          fill_in "パスワード再入力", with: "ab"
          click_button "変更"
          expect(page).to have_content "パスワードリセットに失敗しました"
          expect(page).to have_current_path(reset_url)
        end
      end

      context "確認用パスワードが空欄" do
        it "パスワードを変更できない" do
          visit login_path
          click_link "パスワードを忘れましたか？"
          fill_in "email", with: user.email
          click_button "申請"
          sleep 1
          # 送信されたメールを取得
          email = ActionMailer::Base.deliveries.last

          # メール本文からURLを抽出（正規表現でhrefのリンクを取得）
          require "base64"
          email_body = email.html_part.body.decoded
          reset_url = email_body.match(/href="([^"]+)"/)[1]

          # パスワードリセットフォームに遷移
          visit reset_url
          fill_in "新しいパスワード", with: "new_password"
          fill_in "パスワード再入力", with: ""
          click_button "変更"
          expect(page).to have_content "パスワードリセットに失敗しました"
          expect(page).to have_current_path(reset_url)
        end
      end

      context "パスワードと確認用パスワードが一致しない" do
        it "パスワードを変更できない" do
          visit login_path
          click_link "パスワードを忘れましたか？"
          fill_in "email", with: user.email
          click_button "申請"
          sleep 1
          # 送信されたメールを取得
          email = ActionMailer::Base.deliveries.last

          # メール本文からURLを抽出（正規表現でhrefのリンクを取得）
          require "base64"
          email_body = email.html_part.body.decoded
          reset_url = email_body.match(/href="([^"]+)"/)[1]

          # パスワードリセットフォームに遷移
          visit reset_url
          fill_in "新しいパスワード", with: "new_password_1"
          fill_in "パスワード再入力", with: "new_password_2"
          click_button "変更"
          expect(page).to have_content "パスワードリセットに失敗しました"
          expect(page).to have_current_path(reset_url)
        end
      end
    end

    describe "マイページ" do
      context "ログインしていない状態" do
        it "マイページへのアクセスが失敗する" do
          visit user_path(user)
          expect(page).to have_current_path(login_path)
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    describe "ユーザー編集" do
      context "フォームの入力値が正常" do
        it "ユーザーの編集が成功する" do
          visit edit_user_path(user)
          fill_in "名前", with: "new_user_name"
          select "OFF", from: "LINE通知"
          click_button "更新"
          expect(page).to have_current_path(user_path(user))
          expect(page).to have_content "new_user_name"
          expect(page).to have_content "OFF"
        end
      end

      context "名前が空欄" do
        it "ユーザーの編集が失敗する" do
          visit edit_user_path(user)
          fill_in "名前", with: ""
          select "OFF", from: "LINE通知"
          click_button "更新"
          expect(page).to have_current_path(user_path(user))
          expect(page).to have_content "更新に失敗しました"
        end
      end
    end

    describe "リンクの遷移" do
      context "ユーザー編集ページ" do
        it "パスワードリセットページへの遷移" do
          visit edit_user_path(user)
          click_link "こちら"
          expect(page).to have_current_path(new_password_reset_path)
        end

        it "LINE友達登録ページへの遷移" do
          visit edit_user_path(user)
          click_link "LINE友達登録"
          expect(page).to have_current_path(line_qr_code_path)
        end
      end
    end
  end
end
