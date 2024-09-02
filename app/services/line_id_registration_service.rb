class LineIdRegistrationService
  MESSAGES = {
    success: "アプリと連携ができました。大切な日に合わせてリマインド通知を受け取ることができます",
    account_exists: "アプリのLINEログインアカウントと連携済みです",
    failure: "アプリ連携に失敗しました。アプリに登録しているメールアドレスと一致しているか確認してください"
  }.freeze

  def initialize(events)
    @events = events
  end

  def save
    @events.each do |event|
      next unless text_message?(event)

      line_id = event["source"]["userId"]
      user = find_user_by_email(event.message["text"])

      message_type = determine_message_type(user, line_id)
      send_message(event["replyToken"], message_type)
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET")
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN")
    end
  end

  def text_message?(event)
    event.is_a?(Line::Bot::Event::Message) && event.type == Line::Bot::Event::MessageType::Text
  end

  def find_user_by_email(text)
    email = text.match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)&.to_s
    User.find_by(email:)
  end

  def determine_message_type(user, line_id)
    return :success if user&.update(line_user_id: line_id)
    return :account_exists if User.exists?(line_user_id: line_id)

    :failure
  end

  def send_message(reply_token, message_type)
    client.reply_message(
      reply_token,
      {
        type: "text",
        text: MESSAGES[message_type]
      }
    )
  end
end
