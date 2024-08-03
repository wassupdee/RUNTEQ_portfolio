module Form
  class EventCollection < Base
    attr_accessor :events

    def initialize(attributes = {})
      super attributes
    end

    def events_attributes=(attributes)
      self.events = attributes.map do |_, v|
        v[:notification_enabled] = ActiveRecord::Type::Boolean.new.cast(v[:notification_enabled])
        Event.new(v)
      end
    end

    def update
      Event.transaction do
        events.each do |event|
          existing_event = Event.find(event.id)
          existing_event.update!(event.attributes.except("created_at", "updated_at"))
        end
      end
    end
  end
end
