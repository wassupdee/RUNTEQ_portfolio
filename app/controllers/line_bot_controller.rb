class LineBotController < ApplicationController
  # アクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:line_id_registration]
    
  # LINEから呼び出されるアクション
  def line_id_registration
    # リクエストのbody（StringIOクラス）を文字列（Stringクラス）に変更
    body = request.body.read

    # parse_events_fromはline-bot-apiのオリジナルメソッド
    # clientは以下で定義したプライベートアクション（が返したインスタンス）
    events = client.parse_events_from(body)
    
    # eventsは配列に入っているので、eachでアクセス。events[0]でもだいたい同じ。
    events.each do |event|
      case event
      when Line::Bot::Event::Message # eventのtype(message, follow, unfollow)の内、messageを指定する
        case event.type
        when Line::Bot::Event::MessageType::Text # massageの中身がテキストだったとき
          @email = event.message['text'].match(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i)&.to_s
          @line_id = event.source['userId']
          @user = User.find_by(email: @email)

          if  @user && @user.update(line_user_id: @line_id)
            client.reply_message(event['replyToken'], { 
              type: 'text',
              text: "アプリと連携ができました。大切な日に合わせてリマインド通知を受け取ることができます"
            })
          else
            client.reply_message(event['replyToken'], {
              type: 'text',
              text: "アプリ連携に失敗しました。アプリに登録しているメールアドレスと一致しているか確認してください"
            })
          end
        end
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end
end
