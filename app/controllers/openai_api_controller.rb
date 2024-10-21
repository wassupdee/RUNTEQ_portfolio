class OpenaiApiController < ApplicationController
  skip_before_action :require_login

  def show
    ai_suggest_service = AiSuggestionService.new(session)
    @message = ai_suggest_service.suggest
    @last_question = Question.order(number: :desc).first
  end
end
