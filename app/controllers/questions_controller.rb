class QuestionsController < ApplicationController
  def show
    @question = Question.find_by(number: params[:id])
    @answers = @question.answers.order(number: :asc)
  end
end
