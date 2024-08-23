class OpenaiApiController < ApplicationController
  skip_before_action :require_login
  before_action :set_client

  def show
    ai_suggest_service = AiSuggestionService.new(@client, session)

    @message = ai_suggest_service.suggest
  end

  private

  # config/initializerにAPI Keyを設定しているので、新しいインスタンスをつくるだけでKeyを読み込んでくれる
  def set_client
    @client = OpenAI::Client.new
  end
end
