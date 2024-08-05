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

  def set_prompt
    [context, *set_q_and_a_pairs]
  end
  
  def questions
    Question.order(number: :asc).pluck(:text)
  end
  
  # セッションに保存された回答を、テキストに変換
  def answers
    fetch_session_values.map do |value|
      if value.is_a?(Array)
        value.map do |item|
          Answer.find_by(value: item)&.text
        end
      else
        Answer.find_by(value:)&.text
      end
    end
  end
  
  def fetch_session_values
    (1..3).map do |i|
      session[:"question#{i}"]
    end
  end
  
  def set_q_and_a_pairs
    (0..2).flat_map do |i|
      if answers[i].is_a?(Array)
        [
          { role: "assistant", content: questions[i] },
          { role: "user", content: answers[i].join(", ") }
        ]
      else
        [
          { role: "assistant", content: questions[i] },
          { role: "user", content: answers[i].to_s }
        ]
      end
    end
  end
  
  def context
    {
      role: "system",
      content: "しばらく会っていない人に連絡を取りたいです。質問と回答を元に最適な文を作成し、本文だけを返して（「こちらの文をどうぞ」というようなGPTが話す文は除いて）。文は、「久しぶり！元気にしている？ふと思って連絡しました！」から始めて（ただし、この文のトーンは回答に合わせて変更して）。顔文字も使ってよいです。過去のGPTとのやりとりは参考にしないでください。仕事関係の相手には敬語を使った文にして。"
    }
  end
end
