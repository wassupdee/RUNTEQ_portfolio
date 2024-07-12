class OpenaiApiController < ApplicationController
  before_action :set_cliant
  
  def chat # レスポンスを返すメソッド
    response = @openai.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ "role": "system", "content": "しばらく会っていない人に連絡を取りたいです。質問と回答を元に最適な文をつくり、文章だけを教えて。文は、「久しぶり！元気にしている？ふと思って連絡しました！」から始めて（ただし、この文のトーンは回答に合わせて変更して）。顔文字も使ってよいです"},
         { "role": "assistant", "content": "質問1 メッセージを送る相手は？" },
         { "role": "user", "content": "友だち"}, 
         { "role": "assistant", "content": "質問2 メッセージに含めたい内容は？" },
         { "role": "user", "content": "最近どうしてる？"}, 
         { "role": "assistant", "content": "質問3 メッセージを送る人の性別は？" },
         { "role": "user", "content": "女" }]
        # temperature: 0.7, # 応答のランダム性を指定
        # max_tokens: 20,  # 応答の長さを指定
      },
      )
    @message = response.dig("choices", 0, "message", "content")
  end

  private

  def set_cliant
    @openai = OpenAI::Client.new # config/initializerにAPI Keyを設定しているので、新しいインスタンスをつくるだけでOK
  end
end

