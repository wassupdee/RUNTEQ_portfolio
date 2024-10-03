require "rails_helper"

RSpec.describe "top_page", type: :system do
  # before do
  #   visit root_path
  # end

  it "メインメッセージが表示されること" do
    visit root_path
    expect(page).to have_content "また、つながろう。"
  end

  describe "ページ遷移確認" do
    context "AIメッセージ作成ボタンをクリック" do
      it "AIメッセージページに遷移する" do
        visit root_path
        click_link "メッセージを作成する"
        expect(page).to have_current_path(introduction_path(1))
      end
    end
    context "連絡帳ボタンをクリック" do
      it "連絡帳ページに遷移する" do
        visit root_path
        click_link "ともだち帳をひらく"
        expect(page).to have_current_path(login_path)
      end
    end
  end
end
