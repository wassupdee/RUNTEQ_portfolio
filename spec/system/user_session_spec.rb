require "rails_helper"

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe "ログイン" do
    describe "ログイン前" do
      context "フォームの入力値が正常" do
        it "ログイン処理が成功する" do
          visit login_path
          fill_in "メールアドレス", with: user.email
          fill_in "パスワード", with: "password"
          expect(find_field("メールアドレス").value).to eq user.email
          expect(find_field("パスワード").value).to eq "password"
          click_button "ログイン"
          expect(page).to have_content "ログインしました"
          # expect(current_path).to eq root_path
          expect(page).to have_current_path(root_path)
        end
      end
      # context "メールアドレスが未入力" do
      #   it "ログイン処理が失敗する" do
      #     visit login_path
      #     fill_in "Email", with: "
      #     fill_in "Password", with: "password"
      #     click_button "Login"
      #     expect(page).to have_content "Login failed"
      #     expect(current_path).to eq login_path
      #   end
      # end

      # context "パスワードが未入力" do
      #   it "ログイン処理が失敗する" do
      #   end
      # end
    end
  end
end