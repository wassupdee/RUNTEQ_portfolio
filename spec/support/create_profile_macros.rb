module CreateProfileMacros
  def create_profile
    page.driver.browser.manage.window.resize_to(1280, 900)
    visit profiles_path
    within("#pc-profiles") do
      click_button "連絡先を作成"
    end
    fill_in "名前", with: "山田太郎"
    fill_in "フリガナ", with: "ヤマダタロウ"
    fill_in "誕生日", with: "2000-2-3"
    fill_in "大切な日", with: "卒業記念日"
    find_all("input[type='date']")[1].set("2020-10-25")
    fill_in "電話番号", with: "000-0000-0000"
    fill_in "メールアドレス", with: "email@example.com"
    fill_in "住所", with: "東京都新宿区西新宿2-8-1"
    fill_in "LINEの名前", with: "やまだ"
    select "１年前", from: "最後に連絡した日"
    fill_in "メモ", with: "メモテスト"
    attach_file "プロフィール画像", Rails.root.join("spec/fixtures/files/valid_image.jpg")
    click_button "登録する"
    expect(page).to have_content "連絡先を登録しました"
    expect(page).to have_current_path(profile_path(Profile.last))
  end
end


