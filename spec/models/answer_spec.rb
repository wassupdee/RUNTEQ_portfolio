require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe "アソシエーションチェック" do

    describe "questionとのアソシエーション" do
      it "questionと1対多の関係にある" do
        expect(answer.question).to eq(question)
      end
    end
  end
end
