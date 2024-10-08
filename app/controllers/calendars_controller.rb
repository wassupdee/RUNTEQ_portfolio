class CalendarsController < ApplicationController
  before_action :set_year, only: %i[index]

  def index
    events = current_user.profiles.flat_map(&:events)

    @events_this_year = events.select { |event| event.date.present? }.map do |event|
      event.date = event.date.change(year: @year)
      event
    end
  end

  private

  def set_year
    @year = params[:start_date].present? ? params[:start_date].to_date.year : Date.today.year
  end
end
