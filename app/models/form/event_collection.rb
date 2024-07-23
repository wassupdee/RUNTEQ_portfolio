class Form::EventCollection < Form::Base
  attr_accessor :events
  FORM_COUNT = 2

  def initialize(attributes = {})
    super attributes

    self.events = FORM_COUNT.times.map { Event.new() } unless self.events.present?
  end

  def events_attributes=(attributes)
    self.events = attributes.map do |_, v|
      v[:notification_enabled] = ActiveRecord::Type::Boolean.new.cast(v[:notification_enabled])
      Event.new(v)
    end
  end

  def update
    Event.transaction do
      self.events.each do |event|
        existing_event = Event.find(event.id)
        existing_event.update!(event.attributes.except("created_at", "updated_at"))
      end
    end
  end
end
