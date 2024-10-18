require "rails_helper"

RSpec.describe "top_page", type: :system do
  include LoginMacros
  let(:user) { create(:user) }

  describe "ログイン前" do
    it "メインメッセージが表示されること" do
      visit root_path
      expect(page).to have_content "また、つながろう。"
      expect(page).to have_content "私の大切なともだちと"
      expect(page).to have_content "つながりつづけよう。"
      expect(page).to have_content "これからも、ずっと"
    end

  #   describe "ページ遷移確認" do
  #     context "AIメッセージ作成ボタンをクリック" do
  #       it "AIメッセージページに遷移する" do
  #         visit root_path
  #         click_link "メッセージを作成する"
  #         expect(page).to have_current_path(introduction_path(1))
  #       end
  #     end
  #     context "連絡帳ボタンをクリック" do
  #       it "連絡帳ページに遷移する" do
  #         visit root_path
  #         click_link "ともだち帳をひらく"
  #         expect(page).to have_current_path(login_path)
  #       end
  #     end
  #   end
  # end

  # describe "ログイン後" do
  #   before { login_as(user) }
  # end

  end
end
