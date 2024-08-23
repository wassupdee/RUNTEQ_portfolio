require "rails_helper"

RSpec.describe Group, type: :model do
  let(:user) { create(:user) }
  let(:group) { create(:group, user:) }

  describe "アソシエーションチェック" do
    describe "userとのアソシエーション" do
      it "userと1対多の関係にある" do
        expect(group.user).to eq(user)
      end
    end

    describe "groups_profilesとのアソシエーション" do
      let!(:profile1) { create(:profile, user:) }
      let!(:profile2) { create(:profile, user:) }
      let!(:groups_profiles1) { create(:groups_profile, profile: profile1, group:) }
      let!(:groups_profiles2) { create(:groups_profile, profile: profile2, group:) }

      it "groups_profilesと1対多の関係にある" do
        expect(group.groups_profiles).to include(groups_profiles1, groups_profiles2)
      end

      it "関連するgroups_profilesがあっても、profileを削除でき、groups_profilesも削除される" do
        expect { group.destroy }.to change { Group.count }.by(-1)
        expect(GroupsProfile.where(id: [groups_profiles1.id, groups_profiles2.id])).to be_empty
      end
    end

    describe "profilesとのアソシエーション" do
      let!(:profile1) { create(:profile, user:) }
      let!(:profile2) { create(:profile, user:) }
      let!(:groups_profiles1) { create(:groups_profile, profile: profile1, group:) }
      let!(:groups_profiles2) { create(:groups_profile, profile: profile2, group:) }

      it "profilesと1対多の関係にある" do
        expect(group.profiles).to include(profile1, profile2)
      end
    end
  end
end
