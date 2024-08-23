require "rails_helper"

RSpec.describe Album, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user:) }
  let(:album) { create(:album, profile:) }

  describe "アソシエーションチェック" do
    describe "profileとのアソシエーション" do
      it "profileと1対多の関係にある" do
        expect(album.profile).to eq(profile)
      end
    end
  end
end
