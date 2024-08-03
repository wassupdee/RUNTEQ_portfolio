class OpenaiApiController < ApplicationController
  skip_before_action :require_login
  before_action :set_cliant, :set_prompt

  # レスポンスを返すメソッド
  def chat
    response = @openai.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: set_prompt
        # temperature: 0.7, # 応答のランダム性を指定
        # max_tokens: 20,  # 応答の長さを指定
      }
    )
    @message = response.dig("choices", 0, "message", "content")
  end

  private

  # config/initializerにAPI Keyを設定しているので、新しいインスタンスをつくるだけでKeyを読み込んでくれる
  def set_cliant
    @openai = OpenAI::Client.new
  end

  def set_questions
    @questions = Question.order(number: :asc).pluck(:text)
  end

  def context
    {
      role: "system",
      content: "しばらく会っていない人に連絡を取りたいです。質問と回答を元に最適な文を作成し、本文だけを返して（「こちらの文をどうぞ」というようなGPTが話す文は除いて）。文は、「久しぶり！元気にしている？ふと思って連絡しました！」から始めて（ただし、この文のトーンは回答に合わせて変更して）。顔文字も使ってよいです。過去のGPTとのやりとりは参考にしないでください。仕事関係の相手には敬語を使った文にして。"
    }
  end

  def set_answers
    raw_session_values
    change_raw_session_values_to_array
    text_answers
    combine_multiple_answers_into_one_array(@text_answers)
  end

  def set_q_and_a_pairs
    @q_and_a_pairs = (0..2).flat_map do |i|
      [
        { role: "assistant", content: @questions[i] },
        { role: "user", content: @final_text_answers[i].to_s }
      ]
    end
  end

  def set_prompt
    set_questions
    set_answers
    set_q_and_a_pairs
    [context, *@q_and_a_pairs]
  end

  def raw_session_values
    @raw_session_values = (1..3).map do |i|
      session[:"question#{i}"]
    end
  end

  def change_raw_session_values_to_array
    @values = []
    @raw_session_values.each do |value|
      if value.is_a?(Array)
        value.each do |n|
          @values << n
        end
      else
        @values << value
      end
    end
  end

  def text_answers
    @text_answers = []
    @values.each do |value|
      @text_answers << Answer.find_by(value:)&.text
    end
  end

  def combine_multiple_answers_into_one_array(text_answers)
    if text_answers.size > 3
      first = text_answers[0]
      middle = text_answers.slice(1, text_answers.size - 2)
      last = text_answers[-1]

      @final_text_answers = [first, middle, last]
    else
      @final_text_answers = text_answers
    end
  end
end
