require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:note) { create(:note, profile: profile) }

  describe "profileとのアソシエーション" do

    it "profileと1対多の関係にある" do
      expect(note.profile).to eq(profile)
    end
  end
end
