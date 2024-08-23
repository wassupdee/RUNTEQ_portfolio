require "rails_helper"

RSpec.describe GroupsProfile, type: :model do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let(:profile) { create(:profile, user: user) }
  let(:groups_profile) { create(:groups_profile, group: group, profile: profile) }

  describe "アソシエーションチェック" do

    describe "groupとのアソシエーション" do
      it "groupと1対多の関係にある" do
        expect(groups_profile.group).to eq(group)
      end
    end

    describe "profileとのアソシエーション" do
      it "profileと1対多の関係にある" do
        expect(groups_profile.profile).to eq(profile)
      end
    end
  end
end
