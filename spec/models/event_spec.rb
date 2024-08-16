require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:event) { create(:event, profile: profile) }

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

    it "日付をUTCからJSTへ変換する" do
      utc = DateTime.new(2024,8,15,23,0,0)
      event = create(:event, profile: profile, date: utc)
      jst = event.change_utc_to_jst(utc)

      expect(jst).to eq(DateTime.new(2024,8,16,8,0,0))
    end

    it "特定の日付の「年」を今年に変更する" do
      date = Date.new(2000,8,15)
      event = create(:event, profile: profile, date: date)
      new_date = event.change_to_current_year

      expect(new_date).to eq(Date.new(Date.today.year,8,15))
    end

    it "通知日は今日か確認する" do
      event_date = DateTime.now + 24.hours
      # change_utc_to_jstメソッドにより、event_dateと比較対象である現在時刻が+9時間となる為、
      # event_dateも+9時間とし基準を揃える
      adjusted_event_date = (event_date + 9.hours).to_date

      days_before_event = 1

      event = create(
        :event,
        profile: profile,
        notification_timing: days_before_event,
        date: adjusted_event_date
      )

      expect(event.scheduled_to_notify_today?).to eq(true)
    end

    it "1profileあたりの登録できるイベント数を2つまでに制限する" do
      event1 = create(:event, profile: profile)
      event2 = create(:event, profile: profile)
      event3 = build(:event, profile: profile)

      event3.valid?

      expect(event3.errors[:events]).to include("大切な日は１つまでしか登録できません")
    end
  end
end
