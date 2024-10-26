require "rails_helper"

RSpec.describe "top_page", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  describe "ログイン前" do
    it "サブメッセージが表示されること" do
      visit root_path
      expect(page).to have_content "３つの質問に答えるだけで、"
      expect(page).to have_content "友だちに送る"
      expect(page).to have_content "最適なメッセージを提案します。"
      expect(page).to have_content "友だちの大切な日を登録すると"
      expect(page).to have_content "LINEでリマインド通知を"
      expect(page).to have_content "受け取れます。"
    end

    context "AIメッセージ作成ボタンをクリック" do
      it "AIメッセージページに遷移する" do
        visit root_path
        click_button "メッセージを作成する"
        expect(page).to have_current_path(introduction_path(1))
      end
    end

    context "連絡帳ボタンをクリック" do
      it "ログインページに遷移する" do
        visit root_path
        click_link "連絡帳をひらく"
        expect(page).to have_current_path(login_path)
      end
    end

    context "使い方リンクをクリック" do
      it "使い方ページに遷移する" do
        visit root_path
        within('.grid') do
          click_link "使い方"
        end
        expect(page).to have_current_path(how_to_use_path)
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    context "連絡帳ボタンをクリック" do
      it "連絡帳一覧ページに遷移する" do
        visit root_path
        click_link "連絡帳をひらく"
        expect(page).to have_current_path(profiles_path)
      end
    end
  end
end
