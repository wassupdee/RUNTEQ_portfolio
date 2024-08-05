class LineBotController < ApplicationController
  skip_before_action :require_login

  protect_from_forgery except: [:save_line_id]

  def save_line_id
    body = request.body.read
    events = client.parse_events_from(body)
    registration_service = LineIdRegistrationService.new(events)
    
    registration_service.save
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET")
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN")
    end
  end
end
