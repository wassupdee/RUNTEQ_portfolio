require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  describe "アソシエーションチェック" do
    it "albumsと1対多の関係にある" do
      album1 = create(:album, profile: profile)
      album2 = create(:album, profile: profile)

      expect(profile.albums).to include(album1, album2)
    end

    it '関連するalbumsがあっても、profileを削除でき、albumsも削除される' do
      album1 = create(:album, profile: profile)
      album2 = create(:album, profile: profile)

      expect{ profile.destroy }.to change { Profile.count }.by(-1)
      expect(Album.where(id: [album1.id, album2.id])).to be_empty
    end
  end
end
