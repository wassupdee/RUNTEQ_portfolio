class LineIdRegistrationService
  def initialize(events)
    @events = events
  end

  def save
    @events.each do |event|
      next unless text_message?(event)

      line_id = event["source"]["userId"]
      user = find_user_by_email(event.message["text"])

      if user&.update(line_user_id: line_id)
        send_success_message(event["replyToken"])
      else
        send_failure_message(event["replyToken"])
      end
    end
  end

  private

  def text_message?(event)
    event.is_a?(Line::Bot::Event::Message) && event.type == Line::Bot::Event::MessageType::Text
  end
  
  def find_user_by_email(text)
    email = text.match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)&.to_s
    User.find_by(email:)
  end

  def send_success_message(reply_token)
    client.reply_message(
      reply_token,
      {
        type: "text",
        text: "アプリと連携ができました。大切な日に合わせてリマインド通知を受け取ることができます"
      }
    )
  end

  def send_failure_message(reply_token)
    client.reply_message(
      reply_token,
      {
        type: "text",
        text: "アプリ連携に失敗しました。アプリに登録しているメールアドレスと一致しているか確認してください"
      }
    )
  end
end
