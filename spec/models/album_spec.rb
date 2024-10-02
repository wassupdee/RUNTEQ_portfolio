require "rails_helper"

RSpec.describe Album, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user:) }
  let(:album) { create(:album, profile:) }
  let(:valid_image) { fixture_file_upload("valid_image.jpg") }
  let(:large_image) { fixture_file_upload("large_image.jpg") }
  let(:invalide_content_type) { fixture_file_upload("invalid_content_type.xlsx") }

  describe "アソシエーションチェック" do
    describe "profileとのアソシエーション" do
      it "profileと1対多の関係にある" do
        expect(album.profile).to eq(profile)
      end
    end
  end

  describe "バリデーションチェック" do
    context "無効なデータの場合" do
      it "無効なファイル形式はアップロードできない" do
        album.images.attach(invalide_content_type)
        expect(album).to be_invalid
      end
      it "５MB以上のファイルはアップロードできない" do
        album.images.attach(large_image)
        expect(album).to be_invalid
      end
      it "画像は４枚以上アップロードできない" do
        4.times { album.images.attach(valid_image) }
        expect(album).to be_invalid
      end
    end

    context "有効なデータの場合" do
      it "正常に画像が保存される" do
        3.times { album.images.attach(valid_image) }
        expect(album).to be_valid
      end
    end
  end
end
