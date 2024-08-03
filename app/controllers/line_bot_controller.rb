class LineBotController < ApplicationController
  skip_before_action :require_login

  protect_from_forgery except: [:line_id_registration]

  def line_id_registration
    body = request.body.read

    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text

          @email = event.message["text"].match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)&.to_s
          @line_id = event["source"]["userId"]
          @user = User.find_by(email: @email)

          if @user && @user.update(line_user_id: @line_id)
            client.reply_message(
              event["replyToken"],
              {
                type: "text",
                text: "アプリと連携ができました。大切な日に合わせてリマインド通知を受け取ることができます"
              }
            )
          else
            client.reply_message(
              event["replyToken"],
              {
                type: "text",
                text: "アプリ連携に失敗しました。アプリに登録しているメールアドレスと一致しているか確認してください"
              }
            )
          end
        end
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET")
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN")
    }
  end
end
