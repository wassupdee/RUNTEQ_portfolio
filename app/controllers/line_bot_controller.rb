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

          # @email = event.message["text"].match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)&.to_s
          @line_id = event["source"]["userId"]
          # @user = User.find_by(email: @email)
          
          @user = find_user_by_email(event.message["text"])

          if @user && @user.update(line_user_id: @line_id)
            send_success_message(event["replyToken"])
          else
            send_failure_message(event["replyToken"])
          end
        end
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET")
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN")
    end
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

  def find_user_by_email(text)
    email = text.match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)&.to_s
    User.find_by(email:)
  end
end
