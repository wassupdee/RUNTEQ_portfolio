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

    # it "通知日は今日か確認する" do
    #   event = create(
    #     :event,
    #     profile: profile,
    #     notification_timing: 1,
    #     date: Date.tomorrow
    #   )

    #   expect(event.scheduled_to_notify_today?).to eq(true)
    # end
  end
end
