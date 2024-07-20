namespace :push_line do
  desc "LINEBOT：大切な日のリマインダー"
  task push_line_message_important_day: :environment do
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    # @users = User.where.not(line_user_id: nil).where(notification_enabled: true).includes(:events)
    # @events = Event.where(user: @users).where.not(date: nil, notification_timing: nil).where(notification_enabled: :on)

    # @events.each do |event|
    #   if event.date - notification_timing == today # 日付だけ比較したい
    #     @line_user_ids << event.user.line_user_id
    #   end
    # end
    
    # message = {
    #   type: 'text',
    #   text: "明日は大切な日です！"
    # }

    # @line_user_ids.each do |line_user_id|
    #   hash = { line_user_id, message }
    # end

    user = User.find(4)
    profile = Profile.find(4)
    event = Event.find(10)

    client.push_message(
      user.line_user_id,
    {
      type: 'text',
      text: "#{profile.name}さんの#{event.name}の#{event.notification_timing}日前です！"
    }
      )
  end
end
