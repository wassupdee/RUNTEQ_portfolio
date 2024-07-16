class QuestionsController < ApplicationController
  skip_before_action :require_login
  def show
    @question = Question.find_by(number: params[:id])
    @answers = @question.answers.order(number: :asc)
  end
end
