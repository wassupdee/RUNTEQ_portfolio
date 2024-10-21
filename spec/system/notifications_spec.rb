require "rails_helper"

RSpec.describe "notifications", type: :system do
  include LoginMacros
  include CreateProfileMacros

  let(:user) { create(:user) }

  describe "通知設定の変更" do
    context "マイページでの通知設定がONの場合" do
      it "通知設定を変更できる" do
        login_as(user)
        create_profile_one
        visit profile_events_path(Profile.last)

        within("[data-index='0']") do
          select "3", from: "form_event_collection_events_attributes_0_notification_timing"
          select "する", from: "form_event_collection_events_attributes_0_notification_enabled"
        end
        within("[data-index='1']") do
          select "30", from: "form_event_collection_events_attributes_1_notification_timing"
          select "しない", from: "form_event_collection_events_attributes_1_notification_enabled"
        end
        click_button "登録する"

        expect(page).to have_current_path(profile_events_path(Profile.last))
        within("[data-index='0']") do
          expect(page).to have_select("form_event_collection_events_attributes_0_notification_timing", selected: "3")
          expect(page).to have_select("form_event_collection_events_attributes_0_notification_enabled", selected: "する")
        end
        within("[data-index='1']") do
          expect(page).to have_select("form_event_collection_events_attributes_1_notification_timing", selected: "30")
          expect(page).to have_select("form_event_collection_events_attributes_1_notification_enabled", selected: "しない")
        end
      end
    end

    context "マイページでの通知設定がOFFの場合" do
      before do
        login_as(user)
        create_profile_one
        visit edit_user_path(user)
        select "OFF", from: "user_notification_enabled"
        click_button "更新"
        visit profile_events_path(Profile.last)
      end

      it "通知設定を変更できない" do
        expect(page).not_to have_selector("form_event_collection_events_attributes_0_notification_timing")
        expect(page).not_to have_selector("form_event_collection_events_attributes_0_notification_enabled")
        expect(page).not_to have_selector("form_event_collection_events_attributes_1_notification_timing")
        expect(page).not_to have_selector("form_event_collection_events_attributes_1_notification_enabled")
        expect(page).not_to have_button("登録する")
      end
      it "通知設定変更を促すメッセージと、マイページ編集画面へのリンクを表示" do
        expect(page).to have_content("※マイページの通知設定がOFFのため、変更できません")
        click_link "こちら"
        expect(page).to have_current_path(edit_user_path(user))
      end
    end
  end

  describe "リンク先への遷移" do
    before do
      login_as(user)
      create_profile_one
      visit profile_events_path(Profile.last)
    end

    context "PC画面" do
      before { page.driver.browser.manage.window.resize_to(768, 900) }
      it "サイドバーにプロフィールの画像と名前が表示される" do
        within("#default-sidebar") do
          expect(page).to have_content("山田太郎")
          expect(page).to have_css("img[src*='valid_image.jpg']")
        end
      end

      it "サイドバーからプロフィール詳細に遷移できること" do
        within("#default-sidebar") do
          click_link "基本情報"
        end
        expect(page).to have_current_path(profile_path(Profile.last))
      end

      it "サイドバーからアルバム一覧に遷移できること" do
        within("#default-sidebar") do
          click_link "アルバム"
        end
        expect(page).to have_current_path(profile_albums_path(Profile.last))
      end

      it "サイドバーから通知設定に遷移できること" do
        within("#default-sidebar") do
          click_link "通知設定"
        end
        expect(page).to have_current_path(profile_events_path(Profile.last))
      end

      it "サイドバーから連絡先一覧に遷移できること" do
        within("#default-sidebar") do
          click_link "連絡先一覧"
        end
        expect(page).to have_current_path(profiles_path)
      end

      it "LINE友達登録ページへの遷移ができること" do
        click_link "LINE友達登録"
        expect(page).to have_current_path(line_qr_code_path)
      end
    end

    context "スマホ画面" do
      before { page.driver.browser.manage.window.resize_to(767, 900) }
      it "トップタブからプロフィール詳細に遷移できること" do
        within("#top-tab") do
          click_link "基本情報"
        end
        expect(page).to have_current_path(profile_path(Profile.last))
      end

      it "トップタブからアルバム一覧に遷移できること" do
        within("#top-tab") do
          click_link "アルバム"
        end
        expect(page).to have_current_path(profile_albums_path(Profile.last))
      end

      it "トップタブから通知設定に遷移できること" do
        within("#top-tab") do
          click_link "通知設定"
        end
        expect(page).to have_current_path(profile_events_path(Profile.last))
      end

      it "LINE友達登録ページへの遷移ができること" do
        click_link "LINE友達登録"
        expect(page).to have_current_path(line_qr_code_path)
      end
    end
  end
end
