module CreateGroupMacros
  def create_group_one
    visit profiles_path
    page.driver.browser.manage.window.resize_to(1280, 900)
    within("#pc-profiles") do
      click_button "グループを作成"
    end
    fill_in "新しいグループ名", with: "グループ1"
    click_button "保存"
    expect(page).to have_content("グループ1")
  end

  def create_group_two
    visit profiles_path
    within("#pc-profiles") do
      click_button "グループを作成"
    end
    fill_in "新しいグループ名", with: "グループ2"
    click_button "保存"
    expect(page).to have_content("グループ2")
  end
end
