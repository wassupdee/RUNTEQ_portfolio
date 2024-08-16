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
end
