require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  describe "アソシエーションチェック" do

    describe "userとのアソシエーション" do
      it "userと1対多の関係にある" do
        expect(profile.user).to eq(user)
      end
    end

    describe "albumsとのアソシエーション" do
      let!(:album1) { create(:album, profile: profile) }
      let!(:album2) { create(:album, profile: profile) }

      it "albumsと1対多の関係にある" do
        expect(profile.albums).to include(album1, album2)
      end

      it '関連するalbumsがあっても、profileを削除でき、albumsも削除される' do
        expect{ profile.destroy }.to change { Profile.count }.by(-1)
        expect(Album.where(id: [album1.id, album2.id])).to be_empty
      end
    end

    describe "eventsとのアソシエーション" do
      let!(:event1) { create(:event, profile: profile) }
      let!(:event2) { create(:event, profile: profile) }

      it "eventsと1対多の関係にある" do
        expect(profile.events).to include(event1, event2)
      end

      it '関連するeventsがあっても、profileを削除でき、eventsも削除される' do
        expect{ profile.destroy }.to change { Profile.count }.by(-1)
        expect(Event.where(id: [event1.id, event2.id])).to be_empty
      end
    end

    describe "groups_profilesとのアソシエーション" do
      let!(:group1) { create(:group, user: user) }
      let!(:group2) { create(:group, user: user) }
      let!(:groups_profiles1) { create(:groups_profile, profile: profile, group: group1) }
      let!(:groups_profiles2) { create(:groups_profile, profile: profile, group: group2) }

      it "groups_profilesと1対多の関係にある" do
        expect(profile.groups_profiles).to include(groups_profiles1, groups_profiles2)
      end

      it '関連するgroups_profilesがあっても、profileを削除でき、groups_profilesも削除される' do
        expect{ profile.destroy }.to change { Profile.count }.by(-1)
        expect(GroupsProfile.where(id: [groups_profiles1.id, groups_profiles2.id])).to be_empty
      end
    end

    describe "groupsとのアソシエーション" do
      let!(:group1) { create(:group, user: user) }
      let!(:group2) { create(:group, user: user) }
      let!(:groups_profiles1) { create(:groups_profile, profile: profile, group: group1) }
      let!(:groups_profiles2) { create(:groups_profile, profile: profile, group: group2) }

      it "groupsと1対多の関係にある" do
        expect(profile.groups).to include(group1, group2)
      end
    end

    describe "noteとのアソシエーション" do
      let!(:note) { create(:note, profile: profile) }

      it "noteと1対1の関係にある" do
        expect(profile.note).to eq(note)
      end
    end
  end
end
