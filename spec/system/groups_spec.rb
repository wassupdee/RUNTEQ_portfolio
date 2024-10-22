require "rails_helper"

RSpec.describe "groups", type: :system do
  include LoginMacros
  include CreateProfileMacros
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit profiles_path
    page.driver.browser.manage.window.resize_to(1280, 900)
  end

  describe "作成" do
    context "正常な入力値" do
      it "グループを作成できること" do
        within("#pc-profiles") do
          click_button "グループを作成"
        end
        fill_in "新しいグループ名", with: "グループ1"
        click_button "保存"
        expect(page).to have_content("グループを登録しました")
        expect(page).to have_content("グループ1")
      end
    end

    context "グループ名が空欄" do
      it "グループ作成に失敗すること" do
        within("#pc-profiles") do
          click_button "グループを作成"
        end
        fill_in "新しいグループ名", with: ""
        click_button "保存"
        expect(page).to have_content("グループを登録できませんでした")
      end
    end
  end

  describe "編集" do
    it "グループの編集ができること" do
      within("#pc-profiles") do
        click_button "グループを作成"
      end
      fill_in "新しいグループ名", with: "グループ1"
      click_button "保存"
      expect(page).to have_content("グループ1")
      find("#edit-group-#{Group.last.id}").click
      expect(page).to have_selector("form#group_form_#{Group.last.id}")
      find("input[value='グループ1']").set("グループ2")
      find("form#group_form_#{Group.last.id} input[value='保存']").click
      expect(page).not_to have_content("グループ1")
      expect(page).to have_content("グループ2")
    end
  end

  describe "削除" do
    it "グループの削除ができること" do
      within("#pc-profiles") do
        click_button "グループを作成"
      end
      fill_in "新しいグループ名", with: "グループ1"
      click_button "保存"
      expect(page).to have_content("グループ1")

      find("#delete-group-#{Group.last.id}").click
      expect(page.accept_confirm).to eq "本当に削除しますか？"
      expect(page).to have_content("グループを削除しました")
      expect(page).not_to have_content("グループ1")
    end
  end
end
