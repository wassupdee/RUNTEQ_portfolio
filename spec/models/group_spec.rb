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

    describe "profilesとのアソシエーション" do
      let!(:profile1) { create(:profile, group:, user:) }
      let!(:profile2) { create(:profile, group:, user:) }

      it "profilesと1対多の関係にある" do
        expect(group.profiles).to include(profile1, profile2)
      end

      it "関連するprofilesがあっても、groupを削除でき、profilesも削除される" do
        expect { group.destroy }.to change { Group.count }.by(-1)
        expect(Profile.where(id: [profile1.id, profile2.id])).to be_empty
      end
    end
  end

  describe "ロジックチェック" do
    context "ransack" do
      it "検索のための属性を定義する" do
        expect(described_class.ransackable_attributes).to eq(%w[id name])
      end
    end
  end

  describe "バリデーションチェック" do
    it "グループ名がない場合、無効である" do
      group = build(:group, name: "")
      group.valid?
      expect(group.errors[:name]).to include("を入力してください")
    end
  end
end
