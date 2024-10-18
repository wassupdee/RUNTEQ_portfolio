require "rails_helper"

RSpec.describe "UserSessions", type: :system do
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
    end
  end
end
