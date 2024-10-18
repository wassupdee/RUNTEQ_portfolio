# require "rails_helper"

# RSpec.describe "header", type: :system do
#   let(:user) { create(:user) }
#   before do
#     login_as(user, scope: :user)
#     visit root_path
#   end

#   describe "ログイン後" do
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

#       context "ログアウトリンクをクリック" do
#         it "ログアウトし、rootページに遷移する" do
#           click_link "ログアウト"
#           expect(page).to have_current_path(root_path)
#           expect(page).to have_link("ログイン", href: login_path)
#         end
#       end
#     end
#   end
# end
