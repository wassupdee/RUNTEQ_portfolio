require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  describe "アソシエーションチェック" do

    describe "albumsとのアソシエーション" do
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

    describe "eventsとのアソシエーション" do
      it "eventsと1対多の関係にある" do
        event1 = create(:event, profile: profile)
        event2 = create(:event, profile: profile)

        expect(profile.events).to include(event1, event2)
      end

      it '関連するeventsがあっても、profileを削除でき、eventsも削除される' do
        event1 = create(:event, profile: profile)
        event2 = create(:event, profile: profile)

        expect{ profile.destroy }.to change { Profile.count }.by(-1)
        expect(Event.where(id: [event1.id, event2.id])).to be_empty
      end
    end

    describe "groups_profilesとのアソシエーション" do
      it "groups_profilesと1対多の関係にある" do
        group1 = create(:group, user: user)
        group2 = create(:group, user: user)

        groups_profiles1 = create(:groups_profile, profile: profile, group: group1)
        groups_profiles2 = create(:groups_profile, profile: profile, group: group2)

        expect(profile.groups_profiles).to include(groups_profiles1, groups_profiles2)
      end

      it '関連するgroups_profilesがあっても、profileを削除でき、groups_profilesも削除される' do
        group1 = create(:group, user: user)
        group2 = create(:group, user: user)

        groups_profiles1 = create(:groups_profile, profile: profile, group: group1)
        groups_profiles2 = create(:groups_profile, profile: profile, group: group2)

        expect{ profile.destroy }.to change { Profile.count }.by(-1)
        expect(GroupsProfile.where(id: [groups_profiles1.id, groups_profiles2.id])).to be_empty
      end
    end

    # describe "groupsとのアソシエーション" do
    #   it "groupsと1対多の関係にある" do
    #     group1 = create(:group, profile: profile)
    #     group2 = create(:group, profile: profile)

    #     expect(profile.groups).to include(group1, group2)
    #   end

    #   it '関連するgroupsがあっても、profileを削除でき、groupsも削除される' do
    #     group1 = create(:group, profile: profile)
    #     group2 = create(:group, profile: profile)

    #     expect{ profile.destroy }.to change { Profile.count }.by(-1)
    #     expect(group.where(id: [group1.id, group2.id])).to be_empty
    #   end
    # end
  end
end
