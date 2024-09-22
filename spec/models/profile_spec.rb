require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user:) }

  describe "アソシエーションチェック" do
    describe "userとのアソシエーション" do
      it "userと1対多の関係にある" do
        expect(profile.user).to eq(user)
      end
    end

    describe "albumsとのアソシエーション" do
      let!(:album1) { create(:album, profile:) }
      let!(:album2) { create(:album, profile:) }

      it "albumsと1対多の関係にある" do
        expect(profile.albums).to include(album1, album2)
      end

      it "関連するalbumsがあっても、profileを削除でき、albumsも削除される" do
        expect { profile.destroy }.to change { Profile.count }.by(-1)
        expect(Album.where(id: [album1.id, album2.id])).to be_empty
      end
    end

    describe "eventsとのアソシエーション" do
      let!(:event1) { create(:event, profile:) }
      let!(:event2) { create(:event, profile:) }

      it "eventsと1対多の関係にある" do
        expect(profile.events).to include(event1, event2)
      end

      it "関連するeventsがあっても、profileを削除でき、eventsも削除される" do
        expect { profile.destroy }.to change { Profile.count }.by(-1)
        expect(Event.where(id: [event1.id, event2.id])).to be_empty
      end
    end

    describe "groups_profilesとのアソシエーション" do
      let!(:group1) { create(:group, user:) }
      let!(:group2) { create(:group, user:) }
      let!(:groups_profiles1) { create(:groups_profile, profile:, group: group1) }
      let!(:groups_profiles2) { create(:groups_profile, profile:, group: group2) }

      it "groups_profilesと1対多の関係にある" do
        expect(profile.groups_profiles).to include(groups_profiles1, groups_profiles2)
      end

      it "関連するgroups_profilesがあっても、profileを削除でき、groups_profilesも削除される" do
        expect { profile.destroy }.to change { Profile.count }.by(-1)
        expect(GroupsProfile.where(id: [groups_profiles1.id, groups_profiles2.id])).to be_empty
      end
    end

    describe "groupsとのアソシエーション" do
      let!(:group1) { create(:group, user:) }
      let!(:group2) { create(:group, user:) }
      let!(:groups_profiles1) { create(:groups_profile, profile:, group: group1) }
      let!(:groups_profiles2) { create(:groups_profile, profile:, group: group2) }

      it "groupsと1対多の関係にある" do
        expect(profile.groups).to include(group1, group2)
      end
    end

    describe "noteとのアソシエーション" do
      let!(:note) { create(:note, profile:) }

      it "noteと1対1の関係にある" do
        expect(profile.note).to eq(note)
      end
    end
  end

  describe "accepts_nested_attributes_for" do
    it "profileモデルが更新される際、ネストされたeventsの属性も保存する" do
      event_attributes = {
        name: "event_name",
        date: Date.today,
        notification_timing: 1,
        notification_enabled: true
      }
      profile_attributes = { events_attributes: [event_attributes] }

      expect { profile.update(profile_attributes) }.to change { profile.events.count }.by(1)

      event = profile.events.last
      expect(event.name).to eq("event_name")
      expect(event.date).to eq(Date.today)
      expect(event.notification_timing).to eq(1)
      expect(event.notification_enabled).to eq("on")
    end
  end

  describe "ロジックチェック" do
    context "誕生日のチェック" do
      it "誕生日の月が今月か判定する（同月の場合）" do
        birthday = create(:event, date: Date.new(2000, Date.today.month, 13), profile:)
        expect(profile.birthdays_this_month).to be_truthy
      end

      it "誕生日の月が今月か判定する（違う月の場合）" do
        birthday = create(:event, date: Date.new(2000, Date.today.next_month.month, 13), profile:)
        expect(profile.birthdays_this_month).to be_falsey
      end
    end

    context "大切な日のチェック" do
      it "大切な日の月が今月か判定する（同月の場合）" do
        # 大切な日は２つ目のレコードのため、１つ目のレコード（誕生日）を作成する
        birthday = create(:event, date: Date.new(2000, Date.today.month, 13), profile:)
        special_day = create(:event, date: Date.new(2019, Date.today.month, 13), profile:)
        expect(profile.special_days_this_month).to be_truthy
      end

      it "大切な日の月が今月か判定する（同月の場合）" do
        # 大切な日は２つ目のレコードのため、１つ目のレコード（誕生日）を作成する
        birthday = create(:event, date: Date.new(2000, Date.today.month, 13), profile:)
        special_day = create(:event, date: Date.new(2019, Date.today.next_month.month, 13), profile:)
        expect(profile.special_days_this_month).to be_falsey
      end
    end

    context "ransack" do
      it "検索のための属性を定義する" do
        expect(described_class.ransackable_attributes).to eq(["name", "furigana", "line_name"])
      end
    end
  end
end
