require "rails_helper"

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question:) }

  describe "アソシエーションチェック" do
    describe "questionとのアソシエーション" do
      it "questionと1対多の関係にある" do
        expect(answer.question).to eq(question)
      end
    end
  end

  describe "バリデーションチェック" do
    it "valueがユニークであること" do
      create(:answer, question:, value: "unique_value")
      duplicated_answer = build(:answer, question:, value: "unique_value")

      expect(duplicated_answer).to be_invalid
    end
  end

  describe "ロジックチェック" do
    it "セッションに各問の回答を保存する" do
      session = {}
      q_and_a = { question1: "question1_answer"}

      Answer.save_answers_to_session(session, q_and_a)
      expect(session[:question1]).to eq("question1_answer")
    end

    it "パラメーターから現在の質問番号を取得する" do
      answer_params = { question1: "question1_answer" }

      question_number = Answer.current_question_number(answer_params)
      expect(question_number).to eq(1)
    end

    it "現在の質問が最後か確認する" do
      first_q_and_a = { question1: "question1_answer" }
      first_question_number = Answer.current_question_number(first_q_and_a)
      expect(Answer.last_question?(first_question_number)).to eq(false)

      last_q_and_a = { question3: "question3_answer" }
      last_question_number = Answer.current_question_number(last_q_and_a)
      expect(Answer.last_question?(last_question_number)).to eq(true)
    end
  end
end
