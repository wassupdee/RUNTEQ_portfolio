require "rails_helper"

RSpec.describe "before_login_header", type: :system do
  let(:user) { create(:user) }
  before { visit root_path }

  describe "PC・スマホ画面共通" do
    describe "ページ遷移確認" do
      context "アプリ名をクリック" do
        it "rootページに遷移する" do
          click_link "Stay Friends ～友だちと再びつながるアプリ～"
          expect(page).to have_current_path(root_path)
        end
      end
    end
  end

  describe "PC画面" do
    describe "ページ遷移確認" do
      context "AIメッセージ作成リンクをクリック" do
        it "AIメッセージページに遷移する" do
          within("#pc-nav") do
            click_link "AIメッセージ作成"
          end
          expect(page).to have_current_path(introduction_path(1))
        end
      end

      context "連絡帳リンクをクリック" do
        it "ログイン画面に遷移する" do
          within("#pc-nav") do
            click_link "連絡帳"
          end
          expect(page).to have_current_path(login_path)
        end
      end

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
    end
  end
end
