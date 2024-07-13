class QuestionsController < ApplicationController
  # before_action :set_q_and_a_form
  def show
    @question = Question.find_by(number: params[:id])
    @answers = @question.answers.order(number: :asc)
  end

  def create
    save_in_session(q_and_a_params)
    current_question_number = get_current_question_number(q_and_a_params)
    next_question_number = current_question_number + 1
    if next_question_number > 3
      redirect_to openai_path
    else
      redirect_to question_path(next_question_number)
    end
  end

  # def answer1
  #   save_in_session(q_and_a_params)
  #   redirect_to question_path()
  # end
  
  # def answer2
  #   save_in_session(q_and_a_params)
  #   redirect_to question3_path
  # end
  
  # def answer3
  #   save_in_session(q_and_a_params)
  #   redirect_to openai_path
  # end

  private

  def save_in_session(q_and_a)
    q_and_a.each do |key, value|
      session[key.to_sym] = value
    end
  end

  # キーをfirstで文字列に変換し、数字を取り出し、数値に変換
  # 1つしか要素がないので、firstや[0]は特定のインデックスを指定する意味合いは弱く、ただ取り出すだけに使っている
  def get_current_question_number(q_and_a)
    q_and_a.keys.first.match(/\d+/)[0].to_i
  end

  def q_and_a_params
    params.require(:answer).permit(:question1, :question2, :question3)
  end
end
