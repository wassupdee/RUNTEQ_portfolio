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
  end
end
