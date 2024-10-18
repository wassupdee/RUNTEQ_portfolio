# require "rails_helper"

# RSpec.describe "before_login_header", type: :system do
#   describe "ログイン前" do
#     describe "ページ遷移確認" do
#       context "アプリ名をクリック" do
#         it "rootページに遷移する" do
#           click_link "Reconnect　～ともだちと再びつながるアプリ～"
#           expect(page).to have_current_path(root_path)
#         end
#       end

#       context "AIメッセージ作成リンクをクリック" do
#         it "AIメッセージページに遷移する" do
#           click_link "AIメッセージ作成"
#           expect(page).to have_current_path(introduction_path(1))
#         end
#       end

#       context "連絡帳リンクをクリック" do
#         it "連絡帳ページに遷移する" do
#           click_link "連絡帳"
#           expect(page).to have_current_path(profiles_path)
#         end
#       end

#       context "ログインリンクをクリック" do
#         it "ログインページに遷移する" do
#           click_link "ログイン"
#           expect(page).to have_current_path(login_path)
#         end
#       end

#       context "新規登録ボタンをクリック" do
#         it "新規登録ページに遷移する" do
#           click_link "新規登録"
#           expect(page).to have_current_path(new_user_path)
#         end
#       end
#     end
#   end
# end
