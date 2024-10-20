class AiSuggestionService
  def initialize(session)
    @session = session
  end

  # レスポンスを返すメソッド
  def suggest
    response = openai_client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: set_prompt
        # temperature: 0.7, # 応答のランダム性を指定
        # max_tokens: 20,  # 応答の長さを指定
      }
    )
    response.dig("choices", 0, "message", "content")
  end

  private

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
      @session[:"question#{i}"]
    end
  end

  def context
    {
      role: "system",
      content: "しばらく会っていない人に連絡を取りたいです。質問と回答を元に最適な文を作成し、本文だけを返して（「こちらの文をどうぞ」というようなGPTが話す文は除いて）。文は、「久しぶり！元気にしている？ふと思って連絡しました！」から始めて（ただし、この文のトーンは回答に合わせて変更して）。顔文字も使ってよいです。過去のGPTとのやりとりは参考にしないでください。仕事関係の相手には敬語を使った文にして。"
    }
  end

  def set_q_and_a_pairs
    (0..2).flat_map do |i|
      generate_q_and_a_pair(questions[i], answers[i])
    end
  end

  def generate_q_and_a_pair(_question, answer)
    content = format_answer_content(answer)
    [
      { role: "assistant", content: },
      { role: "user", content: }
    ]
  end

  def format_answer_content(answer)
    answer.is_a?(Array) ? answer.join(", ") : answer.to_s
  end

  def openai_client
    OpenAI::Client.new
  end
end
