require 'rails_helper'

RSpec.describe Authentication, type: :model do
  let(:user) { create(:user) }
  let(:authentication) { create(:authentication, user: user) }

  describe "アソシエーションチェック" do

    describe "userとのアソシエーション" do
      it "userと1対多の関係にある" do
        expect(authentication.user).to eq(user)
      end
    end
  end
end
