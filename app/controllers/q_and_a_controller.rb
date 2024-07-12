class QAndAController < ApplicationController
  # before_action :set_q_and_a_form

  def question1;end
  def question2;end
  def question3;end

  def answer1
    key = q_and_a_params.keys.first.to_sym
    value = q_and_a_params.values.join
    session[key] = value
    redirect_to question2_path
  end
  
  def answer2
    key = q_and_a_params.keys.first.to_sym
    value = q_and_a_params.values.join
    session[key] = value
    redirect_to question3_path
  end
  
  def answer3
    key = q_and_a_params.keys.first.to_sym
    value = q_and_a_params.values.join
    session[key] = value
  end

  private

  # def set_q_and_a_form
  #   @q_and_a_form = QAndAForm.new(session)
  # end

  def q_and_a_params
    params.require(:answer).permit(:question1, :question2, :question3)
  end
end
