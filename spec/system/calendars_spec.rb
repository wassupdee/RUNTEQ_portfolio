require "rails_helper"

RSpec.describe "line_setting_page", type: :system do
  include LoginMacros
  include CreateProfileMacros

  let(:user) { create(:user) }

  before do
    login_as(user)
    create_profile_one
    visit calendars_path
  end

  context "PC画面、スマホ画面共通" do
    describe "画面遷移" do
      it "今月のカレンダーが表示される" do
        expect(page).to have_content("#{Date.today.month}月 #{Date.today.year}")
      end
      context "次月ボタンをクリックすると" do
        it "次月のカレンダーが表示される" do
          click_link "次月"
          if Date.today.year == 12
            expect(page).to have_content("1月 #{Date.today.year + 1}")
          else
            expect(page).to have_content("#{Date.today.month + 1}月 #{Date.today.year}")
          end
        end
      end
      context "前月ボタンをクリックすると" do
        it "前月のカレンダーが表示される" do
          click_link "前月"
          if Date.today.year == 1
            expect(page).to have_content("12月 #{Date.today.year - 1}")
          else
            expect(page).to have_content("#{Date.today.month - 1}月 #{Date.today.year}")
          end
        end
      end
    end
  end

  context "PC画面" do
    before { page.driver.browser.manage.window.resize_to(1280, 900) }

    describe "イベントの表示" do
      it "登録した誕生日がその月に表示される" do
        birthday_month = Profile.last.events.first.date.month
        this_month = Date.today.month

        if birthday_month < this_month
          (birthday_month + 12 - this_month).times { click_link "次月" }
          within("#pc-table") do
            click_link "山田太郎の誕生日"
          end
          expect(page).to have_current_path(profile_path(Profile.last))
        elsif birthday_month > this_month
          (birthday_month - this_month).times { click_link "次月" }
          within("#pc-table") do
            click_link "山田太郎の誕生日"
          end
        else
          within("#pc-table") do
            click_link "山田太郎の誕生日"
          end
        end
      end

      it "登録した大切な日がその月に表示される" do
        important_day_month = Profile.last.events.last.date.month
        this_month = Date.today.month

        if important_day_month < this_month
          (important_day_month + 12 - this_month).times { click_link "次月" }
          within("#pc-table") do
            click_link "山田太郎の卒業記念日"
          end
          expect(page).to have_current_path(profile_path(Profile.last))
        elsif important_day_month > this_month
          (important_day_month - this_month).times { click_link "次月" }
          within("#pc-table") do
            click_link "山田太郎の卒業記念日"
          end
        else
          within("#pc-table") do
            click_link "山田太郎の卒業記念日"
          end
        end
      end
    end
  end

  context "スマホ画面" do
    before { page.driver.browser.manage.window.resize_to(767, 900) }

    describe "イベントの表示" do
      it "登録した誕生日がその月に表示される" do
        birthday_month = Profile.last.events.first.date.month
        this_month = Date.today.month

        if birthday_month < this_month
          (birthday_month + 12 - this_month).times { click_link "次月" }
          within("#mobile-table") do
            click_link "山田太郎の誕生日"
          end
          expect(page).to have_current_path(profile_path(Profile.last))
        elsif birthday_month > this_month
          (birthday_month - this_month).times { click_link "次月" }
          within("#mobile-table") do
            click_link "山田太郎の誕生日"
          end
        else
          within("#mobile-table") do
            click_link "山田太郎の誕生日"
          end
        end
      end

      it "登録した大切な日がその月に表示される" do
        important_day_month = Profile.last.events.last.date.month
        this_month = Date.today.month

        if important_day_month < this_month
          (important_day_month + 12 - this_month).times { click_link "次月" }
          within("#mobile-table") do
            click_link "山田太郎の卒業記念日"
          end
          expect(page).to have_current_path(profile_path(Profile.last))
        elsif important_day_month > this_month
          (important_day_month - this_month).times { click_link "次月" }
          within("#mobile-table") do
            click_link "山田太郎の卒業記念日"
          end
        else
          within("#mobile-table") do
            click_link "山田太郎の卒業記念日"
          end
        end
      end
    end
  end
end
