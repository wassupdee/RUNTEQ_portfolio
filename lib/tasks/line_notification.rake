namespace :push_line do
  desc "LINEBOT：大切な日のリマインダー"
  task push_line_message_important_day: :environment do
    message = {
      type: 'text',
      text: "明日は大切な日です！"
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    client.push_message("hoge", message) # 第一引数に、Line User IDを入れる
  end
end
