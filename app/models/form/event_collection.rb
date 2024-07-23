class Form::EventCollection < Form::Base
  attr_accessor :events
  FORM_COUNT = 2

  def initialize(attributes = {})
    super attributes

    self.events = FORM_COUNT.times.map { Event.new() } unless self.events.present?
  end

  def events_attributes=(attributes)
    self.events= attributes.map { |_, v| Event.new(v) }
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
