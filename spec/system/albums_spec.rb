require "rails_helper"

RSpec.describe "profiles", type: :system do
  include LoginMacros
  include CreateProfileMacros
  include CreateAlbumMacros

  let(:user) { create(:user) }

  describe "アルバム作成" do
    before do
      login_as(user)
      create_profile_one
      visit profile_albums_path(Profile.last)
    end

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

  describe "アルバム編集" do
    before do
      login_as(user)
      create_profile_one
      create_album_one
      visit profile_albums_path(Profile.last)
    end

    context "フォームの入力値が正常" do
      it "アルバムの更新が成功する" do
        find("#edit-album-#{Album.last.id}").click
        fill_in "日付", with: "05-10-2023"
        fill_in "タイトル", with: "海"
        fill_in "ノート", with: "また行きたい"
        attach_file "album_images", Rails.root.join("spec/fixtures/files/valid_image.jpg")
        click_button "保存する"
        expect(page).to have_content "アルバムを更新しました"
        expect(page).to have_current_path(profile_albums_path(Profile.last))
      end
    end

    context "プロフィール画像がpng, jpeg以外のファイル形式の場合" do
      it "アルバムの更新が失敗する" do
        find("#edit-album-#{Album.last.id}").click
        fill_in "日付", with: "05-10-2023"
        fill_in "タイトル", with: "海"
        fill_in "ノート", with: "また行きたい"
        attach_file "album_images", Rails.root.join("spec/fixtures/files/invalid_content_type.xlsx")
        click_button "保存する"
        expect(page).to have_content "更新に失敗しました"
        expect(page).to have_current_path(edit_profile_album_path(Profile.last, Album.last))
      end
    end

    context "プロフィール画像が3MB以上の場合" do
      it "アルバムの更新が失敗する" do
        find("#edit-album-#{Album.last.id}").click
        fill_in "日付", with: "05-10-2023"
        fill_in "タイトル", with: "海"
        fill_in "ノート", with: "また行きたい"
        attach_file "album_images", Rails.root.join("spec/fixtures/files/large_image.jpg")
        click_button "保存する"
        expect(page).to have_content "更新に失敗しました"
        expect(page).to have_current_path(edit_profile_album_path(Profile.last, Album.last))
      end
    end

    context "プロフィール画像を3枚以上保存する場合" do
      it "アルバムの更新が失敗する" do
        find("#edit-album-#{Album.last.id}").click
        fill_in "日付", with: "05-10-2023"
        fill_in "タイトル", with: "海"
        fill_in "ノート", with: "また行きたい"
        attach_file "album_images", [
          Rails.root.join("spec/fixtures/files/valid_image.jpg"),
          Rails.root.join("spec/fixtures/files/valid_image.jpg"),
        ], multiple: true
        click_button "保存する"
        expect(page).to have_content "更新に失敗しました"
        expect(page).to have_current_path(edit_profile_album_path(Profile.last, Album.last))
      end
    end
  end

  describe "アルバム詳細" do
    before do
      login_as(user)
      create_profile_one
      create_album_one
      visit profile_album_path(Profile.last, Profile.last.albums.last)
    end

    describe "画面遷移" do
      it "編集アイコンをクリックすると、編集ページに遷移する" do
        find("#edit-album-#{Profile.last.albums.last.id}").click
        expect(page).to have_current_path(edit_profile_album_path(Profile.last, Profile.last.albums.last))
      end
    end

    describe "表示" do
      it "アルバム詳細情報が表示されている" do
        expect(page).to have_content("海外旅行")
        expect(page).to have_content("楽しかった！")
        expect(page).to have_css("img[src*='valid_image.jpg']")
      end
    end
  end

  describe "アルバム一覧" do
    before do
      login_as(user)
      create_profile_one
      create_album_one
      create_album_two
      visit profile_albums_path(Profile.last)
    end

    describe "画面遷移" do
      it "詳細アイコンをクリックすると、詳細ページに遷移する" do
        find("#album-#{Profile.last.albums.last.id}").click
        expect(page).to have_current_path(profile_album_path(Profile.last, Profile.last.albums.last))
      end
      it "編集アイコンをクリックすると、編集ページに遷移する" do
        find("#edit-album-#{Profile.last.albums.last.id}").click
        expect(page).to have_current_path(edit_profile_album_path(Profile.last, Profile.last.albums.last))
      end
    end

    describe "表示" do
      it "作成されたアルバムが表示される" do
        expect(page).to have_content("海外旅行")
        expect(page).to have_content("祭り")
      end
    end
  end

  describe "アルバム削除" do
    before do
      login_as(user)
      create_profile_one
      create_album_one
      visit profile_album_path(Profile.last, Profile.last.albums.last)
    end

    it "アルバム詳細ページでアルバムを削除できる" do
      find("#delete-album-#{Album.last.id}").click
      expect(page.accept_confirm).to eq "削除しますか？"
      expect(page).not_to have_css("#album-#{Album.last.id}")
    end
  end
end
