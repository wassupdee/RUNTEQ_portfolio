require "rails_helper"

RSpec.describe "profiles", type: :system do
  include LoginMacros
  include CreateProfileMacros
  let(:user) { create(:user) }


  before do
    login_as(user)
    create_profile_one
    visit profile_albums_path(Profile.last)
  end

  describe "アルバム作成" do
    context "フォームの入力値が正常" do
      it "アルバムの作成が成功する" do
        click_button "アルバムを作成"
        fill_in "日付", with: "05-09-2023"
        fill_in "タイトル", with: "海外旅行"
        fill_in "ノート", with: "楽しかった！"
        attach_file "album_images", [
          Rails.root.join("spec/fixtures/files/valid_image.jpg"),
          Rails.root.join("spec/fixtures/files/valid_image.jpg")
        ], multiple: true
        click_button "保存する"
        expect(page).to have_content "アルバムを登録しました"
        expect(page).to have_current_path(profile_albums_path(Profile.last))
      end
    end

    context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
      it "アルバムの作成が失敗する" do
        click_button "アルバムを作成"
        fill_in "日付", with: "05-09-2023"
        fill_in "タイトル", with: "海外旅行"
        fill_in "ノート", with: "楽しかった！"
        attach_file "album_images", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
        click_button "保存する"
        expect(page).to have_content "登録に失敗しました"
        expect(page).to have_current_path(new_profile_album_path(Profile.last))
      end
    end

    context "プロフィール画像が3MB以上の場合" do
      it "アルバムの作成が失敗する" do
        click_button "アルバムを作成"
        fill_in "日付", with: "05-09-2023"
        fill_in "タイトル", with: "海外旅行"
        fill_in "ノート", with: "楽しかった！"
        attach_file "album_images", Rails.root.join("spec/fixtures/files/large_image.jpg")
        click_button "保存する"
        expect(page).to have_content "登録に失敗しました"
        expect(page).to have_current_path(new_profile_album_path(Profile.last))
      end
    end

    context "プロフィール画像を3枚以上保存する場合" do
      it "アルバムの作成が失敗する" do
        click_button "アルバムを作成"
        fill_in "日付", with: "05-09-2023"
        fill_in "タイトル", with: "海外旅行"
        fill_in "ノート", with: "楽しかった！"
        attach_file "album_images", [
          Rails.root.join("spec/fixtures/files/valid_image.jpg"),
          Rails.root.join("spec/fixtures/files/valid_image.jpg"),
          Rails.root.join("spec/fixtures/files/valid_image.jpg")
        ], multiple: true
        click_button "保存する"
        expect(page).to have_content "登録に失敗しました"
        expect(page).to have_current_path(new_profile_album_path(Profile.last))
      end
    end
  end
end