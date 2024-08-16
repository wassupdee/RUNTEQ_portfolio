require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }

  describe "アソシエーションチェック" do
    describe "userとのアソシエーション" do
      it "userと1対多の関係にある" do
        expect(group.user).to eq(user)
      end
    end
  end
end
