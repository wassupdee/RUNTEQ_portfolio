require "rails_helper"

RSpec.describe "UserSessions", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  describe "ログイン" do
    describe "ログイン前" do
      context "フォームの入力値が正常" do
        it "ログイン処理が成功する" do
          visit login_path
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: "password"
          click_button "ログイン"
          expect(page).to have_content "ログインしました"
          expect(page).to have_current_path(root_path)
        end
      end
      context "メールアドレスが未入力" do
        it "ログイン処理が失敗する" do
          visit login_path
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: "password"
          click_button "ログイン"
          expect(page).to have_content "メールアドレスまたはパスワードが正しくありません"
          expect(page).to have_current_path(login_path)
        end
      end

      context "パスワードが未入力" do
        it "ログイン処理が失敗する" do
          visit login_path
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: ""
          click_button "ログイン"
          expect(page).to have_content "メールアドレスまたはパスワードが正しくありません"
          expect(page).to have_current_path(login_path)
        end
      end
    end
  end

  describe "ログアウト" do
    context "ログアウトボタンをクリック" do
      it "ログアウト処理が成功する" do
        login_as(user)
        visit root_path
        expect(page).to have_content("ログアウト")
        click_link "ログアウト", match: :first
        expect(page).to have_content "ログアウトしました"
        expect(page).to have_current_path(root_path)
      end
    end
  end
end
