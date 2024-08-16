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

  describe "バリデーションチェック" do
    it "valueがユニークであること" do
      answer = create(:answer, question: question, value: "unique_value")
      duplicated_answer = build(:answer, question: question, value: "unique_value")

      expect(duplicated_answer).to be_invalid
    end
  end
end
