class CalendarsController < ApplicationController
  def index
    events = current_user.profiles.flat_map(&:events)
    year = params[:start_date].to_date.year

    @events_this_year = events.map do |event|
      event.date = event.date.change(year:)
      event
    end
  end
end
