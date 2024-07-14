class OpenaiApiController < ApplicationController
  before_action :set_cliant, :questions, :answers

  # レスポンスを返すメソッド
  def chat
    response = @openai.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: set_prompt
        # temperature: 0.7, # 応答のランダム性を指定
        # max_tokens: 20,  # 応答の長さを指定
      },
      )
    @message = response.dig("choices", 0, "message", "content")
  end

  private

 # config/initializerにAPI Keyを設定しているので、新しいインスタンスをつくるだけでKeyを読み込んでくれる
  def set_cliant
    @openai = OpenAI::Client.new
  end

  def context
    { "role": "system", "content": "しばらく会っていない人に連絡を取りたいです。質問と回答を元に最適な文をつくり、文章だけを教えて。文は、「久しぶり！元気にしている？ふと思って連絡しました！」から始めて（ただし、この文のトーンは回答に合わせて変更して）。顔文字も使ってよいです" }
  end

  def questions
    @questions = Question.order(number: :asc).pluck(:text)
  end

  def answers
    @answers = (1..3).map do |i|
      Answer.find_by(value: session["question#{i}".to_sym])&.text
    end
  end

  def q_and_a_pair(i)
    [{ "role": "assistant", "content": @questions[i] },
    { "role": "user", "content": @answers[i] }]
  end

  def set_prompt
    q_and_a_pairs = (0..2).flat_map{ |i| q_and_a_pair(i) }
    [context, *q_and_a_pairs]
  end
end

