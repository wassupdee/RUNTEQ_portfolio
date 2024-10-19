require "rails_helper"

RSpec.describe "before_login_footer", type: :system do
  let(:user) { create(:user) }

  describe "PC画面" do
    before do
      visit root_path
      page.driver.browser.manage.window.resize_to(768, 900)
    end

    describe "ページ遷移確認" do
      context "利用規約ボタンをクリック" do
        it "利用規約ページに遷移する" do
          within("#pc-footer") do
            click_link "利用規約"
          end
          expect(page).to have_current_path(terms_path)
        end
      end

      context "プライバシーポリシーボタンをクリック" do
        it "プライバシーポリシーページに遷移する" do
          within("#pc-footer") do
            click_link "プライバシーポリシー"
          end
          expect(page).to have_current_path(privacy_policy_path)
        end
      end

      context "お問い合わせボタンをクリック" do
        it "お問い合わせページに遷移する" do
          within("#pc-footer") do
            click_link "お問い合わせ"
          end
          expect(page).to have_current_path("https://docs.google.com/forms/d/e/1FAIpQLScyntUUOKze4OmcuIShk5VLcZu-8JEHIAqB6GCKeti32fG6vg/viewform")
        end
      end
    end
  end

  describe "スマホ画面" do
    before do
      visit root_path
      page.driver.browser.manage.window.resize_to(767, 900)
    end

    describe "ページ遷移確認" do
      context "AIメッセージ作成リンクをクリック" do
        it "AIメッセージページに遷移する" do
          within("#mobile-footer") do
            click_link "AIメッセージ"
          end
          expect(page).to have_current_path(introduction_path(1))
        end
      end

      context "連絡帳リンクをクリック" do
        it "ログイン画面に遷移する" do
          within("#mobile-footer") do
            click_link "連絡帳"
          end
          expect(page).to have_current_path(login_path)
        end
      end

      context "使い方リンクをクリック" do
        it "使い方ページに遷移する" do
          within("#mobile-footer") do
            click_link "使い方"
          end
          expect(page).to have_current_path(how_to_use_path)
        end
      end

      context "ログインリンクをクリック" do
        it "ログイン画面に遷移する" do
          within("#mobile-footer") do
            click_link "ログイン"
          end
          expect(page).to have_current_path(login_path)
        end
      end

      context "新規登録ボタンをクリック" do
        it "新規登録ページに遷移する" do
          within("#mobile-footer") do
            click_link "新規登録"
          end
          expect(page).to have_current_path(new_user_path)
        end
      end
    end
  end
end
