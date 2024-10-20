module CreateAlbumMacros
  def create_album
    visit profile_albums_path(Profile.last)
    click_button "アルバムを作成"
    fill_in "日付", with: "05-09-2023"
    fill_in "タイトル", with: "海外旅行"
    fill_in "ノート", with: "楽しかった！"
    attach_file "album_images", Rails.root.join("spec/fixtures/files/valid_image.jpg")
    click_button "保存する"
    expect(page).to have_content "アルバムを登録しました"
    expect(page).to have_current_path(profile_albums_path(Profile.last))
  end
end
