require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user:) }
  let(:valid_image) { fixture_file_upload("valid_image.jpg") }
  let(:large_image) { fixture_file_upload("large_image.jpg") }
  let(:invalide_content_type) { fixture_file_upload("invalid_content_type.xlsx") }

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

    describe "groupsとのアソシエーション" do
      let!(:group) { create(:group, user:) }
      let!(:profile1) { create(:profile, group:, user:) }
      let!(:profile2) { create(:profile, user:) }

      it "groupと1対多の関係にある" do
        expect(profile1.group).to eq(group)
      end

      it "groupとアソシエーションせずともprofileレコードを作成できる" do
        expect(profile2.group).to be_nil
        expect(profile2).to be_valid
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
        create(:event, date: Date.new(2000, Date.today.month, 13), profile:)
        expect(profile.birthdays_this_month).to be_truthy
      end

      it "誕生日の月が今月か判定する（違う月の場合）" do
        create(:event, date: Date.new(2000, Date.today.next_month.month, 13), profile:)
        expect(profile.birthdays_this_month).to be_falsey
      end
    end

    context "大切な日のチェック" do
      it "大切な日の月が今月か判定する（同月の場合）" do
        # 大切な日は２つ目のレコードのため、１つ目のレコード（誕生日）を作成する
        create(:event, date: Date.new(2000, Date.today.month, 13), profile:)
        create(:event, date: Date.new(2019, Date.today.month, 13), profile:)
        expect(profile.special_days_this_month).to be_truthy
      end

      it "大切な日の月が今月か判定する（同月の場合）" do
        # 大切な日は２つ目のレコードのため、１つ目のレコード（誕生日）を作成する
        create(:event, date: Date.new(2000, Date.today.month, 13), profile:)
        create(:event, date: Date.new(2019, Date.today.next_month.month, 13), profile:)
        expect(profile.special_days_this_month).to be_falsey
      end
    end

    context "ransack" do
      it "検索のための属性を定義する" do
        expect(described_class.ransackable_attributes).to eq(%w[name furigana line_name last_contacted])
      end

      it "検索のためのアソシエーション先のモデルを定義する" do
        expect(described_class.ransackable_associations).to eq(%w[group])
      end
    end
  end

  describe "enumチェック" do
    it "last_contactedにenumが付いている" do
      expect(described_class.last_contacteds).to eq({ "within_one_month" => 0, "within_one_year" => 1, "within_three_years" => 2, "more_than_three_years" => 3 })
    end
  end

  describe "バリデーションチェック" do
    context "無効なデータの場合" do
      it "無効なファイル形式はアップロードできない" do
        profile.avatar.attach(invalide_content_type)
        expect(profile).to be_invalid
      end
      it "１MB以上のファイルはアップロードできない" do
        profile.avatar.attach(large_image)
        expect(profile).to be_invalid
      end
    end

    context "有効なデータの場合" do
      it "正常に画像が保存される" do
        profile.avatar.attach(valid_image)
        expect(profile).to be_valid
      end
    end
  end
end
