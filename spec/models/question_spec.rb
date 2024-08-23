require "rails_helper"

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }
  describe "アソシエーションチェック" do
    it 'answersと1対多の関係にある' do
      answer1 = create(:answer, question: question)
      answer2 = create(:answer, question: question)

      expect(question.answers).to include(answer1, answer2)
    end

    it '関連するanswersがあっても、questionを削除でき、answersも削除される' do
      answer1 = create(:answer, question: question)
      answer2 = create(:answer, question: question)

      expect{ question.destroy }.to change { Question.count }.by(-1)
      expect(Answer.where(id: [answer1.id, answer2.id])).to be_empty
    end
  end
end
