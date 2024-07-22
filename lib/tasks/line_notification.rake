namespace :push_line do
  desc "LINEBOT：イベントのリマインダー"
  task event_notification: :environment do
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }

    users = User.where.not(line_user_id: nil).where(notification_enabled: :on).includes(profiles: :events)
    users.each do |user|
      user.events.each do |event|
        if event.is_ready_to_notify? && event.is_scheduled_to_notify_today?
          client.push_message(
            user.line_user_id,
          {
            type: 'text',
            text: "#{event.profile.name}さんの#{event.name}の#{event.notification_timing}日前です！"
          }
            )
        end
      end
    end
  end
end
