namespace :push_line do
  desc "LINEBOT：イベントのリマインダー"
  task event_notification: :environment do
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET")
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN")
    end

    users = User.only_ready_to_notify.includes(profiles: :events)
    users.each do |user|
      user.events.each do |event|
        next unless event.is_ready_to_notify? && event.is_scheduled_to_notify_today?

        client.push_message(
          user.line_user_id,
          {
            type: "text",
            text: "#{event.profile.name}さんの#{event.name}の#{event.notification_timing}日前です！"
          }
        )
      end
    end
  end
end
