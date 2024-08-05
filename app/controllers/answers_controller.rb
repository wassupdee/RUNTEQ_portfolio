class AnswersController < ApplicationController
  skip_before_action :require_login

  def create
    Answer.save_answers_to_session(session, answer_params)

    current_question_number = Answer.current_question_number(answer_params)
    if Answer.last_question?(current_question_number)
      redirect_to ai_message_path
    else
      redirect_to question_path(current_question_number + 1)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:question1, :question3, question2: [])
  end
end
