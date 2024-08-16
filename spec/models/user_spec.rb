require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "名前、メール、パスワード、確認用パスワード、notification_enabledがある場合、有効である" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "名前がない場合、無効である" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "名前が255文字以上場合、無効である" do
      user = build(:user, name: "n" * 256)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 255 characters)")
    end

    it "メールアドレスがない場合、無効である" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "重複したメールアドレスの場合、無効である" do
      other_user = create(:user)
      user = build(:user, email: other_user.email)
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "パスワードが2文字以下の場合、無効である" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 3 characters)")
    end

    it "パスワード(確認用）がない場合、無効である" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "パスワード(確認用）がパスワードと一致しない場合、無効である" do
      user = build(:user, password: "password", password_confirmation: "apple")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "notificaiton_enabledない場合、無効である" do
      user = build(:user, notification_enabled: "")
      user.valid?
      expect(user.errors[:notification_enabled]).to include("can't be blank")
    end

    it "重複したline_user_idの場合、無効である" do
      other_user = create(:user)
      user = build(:user, line_user_id: other_user.line_user_id)
      user.valid?
      expect(user.errors[:line_user_id]).to include("has already been taken")
    end

    it "line_user_idがblankの場合、重複していても有効である" do
      other_user = create(:user, line_user_id: "")
      user = build(:user, line_user_id: "")
      user.valid?
      expect(user.errors[:line_user_id]).not_to include("has already been taken")
    end

    it "notification_enabledがenumで定義されている" do
      user1 = create(:user, notification_enabled: true)
      user2 = create(:user, notification_enabled: false)
      expect(user1.notification_enabled).to eq("on")
      expect(user2.notification_enabled).to eq("off")
    end
  end

  describe "アソシエーションチェック" do
    let(:user) { create(:user) }

    describe "profilesとのアソシエーション" do
      let!(:profile1) { create(:profile, user: user) }
      let!(:profile2) { create(:profile, user: user) }

      it "profilesと1対多の関係にある" do
        expect(user.profiles).to include(profile1, profile2)
      end

      it '関連するprofilesがあっても、userを削除でき、profilesも削除される' do
        expect{ user.destroy }.to change { User.count }.by(-1)
        expect(Profile.where(id: [profile1.id, profile2.id])).to be_empty
      end
    end

    describe "groupsとのアソシエーション" do
      let!(:group1) { create(:group, user: user) }
      let!(:group2) { create(:group, user: user) }

      it "groupsと1対多の関係にある" do
        expect(user.groups).to include(group1, group2)
      end

      it '関連するgroupsがあっても、userを削除でき、groupsも削除される' do
        expect{ user.destroy }.to change { User.count }.by(-1)
        expect(Group.where(id: [group1.id, group2.id])).to be_empty
      end
    end

    describe "authenticationsとのアソシエーション" do
      let!(:authentication1) { create(:authentication, user: user) }
      let!(:authentication2) { create(:authentication, user: user) }

      it "authenticationsと1対多の関係にある" do
        expect(user.authentications).to include(authentication1, authentication2)
      end

      it '関連するauthenticationsがあっても、userを削除でき、authenticationsも削除される' do
        expect{ user.destroy }.to change { User.count }.by(-1)
        expect(Authentication.where(id: [authentication1.id, authentication2.id])).to be_empty
      end
    end

    describe "eventsとのアソシエーション" do
      let!(:profile) { create(:profile, user: user) }
      let!(:event1) { create(:event, profile: profile) }
      let!(:event2) { create(:event, profile: profile) }

      it "eventsと1対多の関係にある" do
        expect(user.events).to include(event1, event2)
      end

      it '関連するeventsがあっても、userを削除でき、eventsも削除される' do
        expect{ user.destroy }.to change { User.count }.by(-1)
        expect(Event.where(id: [event1.id, event2.id])).to be_empty
      end
    end
  end
end
