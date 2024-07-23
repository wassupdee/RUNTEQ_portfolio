class Form::EventCollection < Form::Base
  attr_accessor :events
  FORM_COUNT = 2

  def initialize(attributes = {})
    super attributes

    if attributes[:events]
      self.events = FORM_COUNT.times.map { Event.new() } unless self.events.present?
    end
  end

  def events_attributes=(attributes)
    self.events= attributes.map { |_, v| Event.new(v) }
  end

  def save
    Event.transaction do
      self.events.map(&:save!)
    end
  end
end
