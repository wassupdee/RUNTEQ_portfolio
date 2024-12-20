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
    before do
      page.driver.browser.manage.window.resize_to(1024, 900)
    end

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

      context "使い方リンクをクリック" do
        it "使い方ページに遷移する" do
          within("#pc-nav") do
            click_link "使い方"
          end
          expect(page).to have_current_path(how_to_use_path)
        end
      end

      context "ログインリンクをクリック" do
        it "ログイン画面に遷移する" do
          within("#pc-nav") do
            click_link "ログイン"
          end
          expect(page).to have_current_path(login_path)
        end
      end

      context "新規登録ボタンをクリック" do
        it "新規登録ページに遷移する" do
          within("#pc-nav") do
            click_link "新規登録"
          end
          expect(page).to have_current_path(new_user_path)
        end
      end
    end
  end

  describe "スマホ画面" do
    before do
      page.driver.browser.manage.window.resize_to(1023, 900)
      find("#open-drawer").click
    end

    describe "ページ遷移確認" do
      context "AIメッセージ作成リンクをクリック" do
        it "AIメッセージページに遷移する" do
          within("#mobile-nav") do
            click_link "AIメッセージ作成"
          end
          expect(page).to have_current_path(introduction_path(1))
        end
      end

      context "連絡帳リンクをクリック" do
        it "ログイン画面に遷移する" do
          within("#mobile-nav") do
            click_link "連絡帳"
          end
          expect(page).to have_current_path(login_path)
        end
      end

      context "使い方リンクをクリック" do
        it "使い方ページに遷移する" do
          within("#mobile-nav") do
            click_link "使い方"
          end
          expect(page).to have_current_path(how_to_use_path)
        end
      end

      context "ログインリンクをクリック" do
        it "ログイン画面に遷移する" do
          within("#mobile-nav") do
            click_link "ログイン"
          end
          expect(page).to have_current_path(login_path)
        end
      end

      context "新規登録ボタンをクリック" do
        it "新規登録ページに遷移する" do
          within("#mobile-nav") do
            click_link "新規登録"
          end
          expect(page).to have_current_path(new_user_path)
        end
      end

      context "利用規約ボタンをクリック" do
        it "利用規約ページに遷移する" do
          within("#mobile-nav") do
            click_link "利用規約"
          end
          expect(page).to have_current_path(terms_path)
        end
      end

      context "プライバシーポリシーボタンをクリック" do
        it "プライバシーポリシーページに遷移する" do
          within("#mobile-nav") do
            click_link "プライバシーポリシー"
          end
          expect(page).to have_current_path(privacy_policy_path)
        end
      end

      context "お問い合わせボタンをクリック" do
        it "お問い合わせページに遷移する" do
          within("#mobile-nav") do
            click_link "お問い合わせ"
          end
          expect(page).to have_current_path("https://docs.google.com/forms/d/e/1FAIpQLScyntUUOKze4OmcuIShk5VLcZu-8JEHIAqB6GCKeti32fG6vg/viewform")
        end
      end
    end
  end
end
