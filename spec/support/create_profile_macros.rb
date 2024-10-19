module CreateProfileMacros
  include CreateGroupMacros

  def create_profile_1
    create_group_1
    visit profiles_path
    page.driver.browser.manage.window.resize_to(1280, 900)
    within("#pc-profiles") do
      click_button "連絡先を作成"
    end
    fill_in "名前", with: "山田太郎"
    fill_in "フリガナ", with: "ヤマダタロウ"
    fill_in "誕生日", with: "02-03-2003"
    fill_in "大切な日", with: "卒業記念日"
    find_all("input[type='date']")[1].set("2-5-2020")
    fill_in "電話番号", with: "000-0000-0000"
    fill_in "メールアドレス", with: "email@example.com"
    fill_in "住所", with: "東京都新宿区西新宿2-8-1"
    fill_in "LINEの名前", with: "やまだ"
    select "１年前", from: "最後に連絡した日"
    select "グループ1", from: "グループ名"
    fill_in "メモ", with: "メモテスト"
    attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
    click_button "登録する"
    expect(page).to have_content "連絡先を登録しました"
    expect(page).to have_current_path(profile_path(Profile.last))
  end

  def create_profile_2
    create_group_2
    visit profiles_path
    page.driver.browser.manage.window.resize_to(1280, 900)
    within("#pc-profiles") do
      click_button "連絡先を作成"
    end
    fill_in "名前", with: "佐藤一郎"
    fill_in "フリガナ", with: "サトウイチロウ"
    fill_in "誕生日", with: "01-15-1990"
    fill_in "大切な日", with: "入社記念日"
    find_all("input[type='date']")[1].set("5-10-2015")
    fill_in "電話番号", with: "090-1234-5678"
    fill_in "メールアドレス", with: "ichiro.sato@example.com"
    fill_in "住所", with: "大阪府大阪市北区梅田1-1-1"
    fill_in "LINEの名前", with: "いちろう"
    select "３年前", from: "最後に連絡した日"
    select "グループ2", from: "グループ名"
    fill_in "メモ", with: "メモテスト"
    attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
    click_button "登録する"
    expect(page).to have_content "連絡先を登録しました"
    expect(page).to have_current_path(profile_path(Profile.last))
  end
end
