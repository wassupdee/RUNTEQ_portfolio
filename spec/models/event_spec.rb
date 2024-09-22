require "rails_helper"

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user:) }
  let(:event) { create(:event, profile:) }

  describe "アソシエーションチェック" do
    describe "profileとのアソシエーション" do
      it "profileと1対多の関係にある" do
        expect(event.profile).to eq(profile)
      end
    end
  end

  describe "ロジックチェック" do
    it "通知の条件を満たしているか確認する" do
      expect(event.ready_to_notify?).to eq(true)
    end

    it "日付をUTCからJSTへ変換する（９時間先に進める）" do
      utc = DateTime.now
      event = create(:event, profile:, date: DateTime.now)
      jst = event.utc_today_to_jst

      expect(jst.change(sec: 0)).to eq((utc + 9.hours).change(sec: 0))
    end

    it "特定の日付の「年」を今年に変更する" do
      date = Date.new(2000, 8, 15)
      event = create(:event, profile:, date:)
      new_date = event.event_date_this_year

      expect(new_date).to eq(Date.new(Date.today.year, 8, 15))
    end

    it "通知日は今日か確認する" do
      event_date = DateTime.now + 24.hours
      # change_utc_to_jstメソッドにより、event_dateと比較対象である現在時刻が+9時間となる為、
      # event_dateも+9時間とし基準を揃える
      adjusted_event_date = (event_date + 9.hours).to_date

      days_before_event = 1

      event = create(
        :event,
        profile:,
        notification_timing: days_before_event,
        date: adjusted_event_date
      )

      expect(event.scheduled_to_notify_today?).to eq(true)
    end
  end

  describe "バリデーションチェック" do
    it "1profileあたりの登録できるイベント数を2つまでに制限する" do
      create(:event, profile:)
      create(:event, profile:)
      event3 = build(:event, profile:)

      event3.valid?

      expect(event3.errors[:events]).to include("大切な日は１つまでしか登録できません")
    end
  end

  describe "enumチェック" do
    it "boolean型のnotification_enabledが、off/onに対応している" do
      expect(described_class.notification_enableds).to eq({ "off" => false, "on" => true })
    end
  end
end
