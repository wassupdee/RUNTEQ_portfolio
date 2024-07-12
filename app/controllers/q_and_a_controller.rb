class QAndAController < ApplicationController
  # before_action :set_q_and_a_form

  def question1;end
  def question2;end
  def question3;end

  def answer1
    save_in_session(q_and_a_params)
    redirect_to question2_path
  end
  
  def answer2
    save_in_session(q_and_a_params)
    redirect_to question3_path
  end
  
  def answer3
    save_in_session(q_and_a_params)
    redirect_to openai_path
  end

  private

  def save_in_session(q_and_a)
    q_and_a.each do |key, value|
      session[key.to_sym] = value
    end
  end

  def q_and_a_params
    params.require(:answer).permit(:question1, :question2, :question3)
  end
end
