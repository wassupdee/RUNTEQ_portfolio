class AnswersController < ApplicationController
  def create
    save_in_session(answer_params)
    
    if last_question?(current_question_number)
      redirect_to openai_path
    else
      redirect_to question_path(current_question_number + 1)
    end
  end

  private

  def save_in_session(q_and_a)
    q_and_a.each do |key, value|
      session[key.to_sym] = value
    end
  end

  # キーをfirstで文字列に変換し、数字を取り出し、数値に変換
  # 1つしか要素がないので、firstや[0]は特定のインデックスを指定する意味合いは弱く、ただ取り出すだけに使っている
  def current_question_number
    answer_params.keys.first.match(/\d+/)[0].to_i
  end
  
  def last_question?(question_number)
    question_number == 3
  end
  
  def answer_params
    params.require(:answer).permit(:question1, :question3, question2: [])
  end
end