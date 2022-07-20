module HasEvent
  extend ActiveSupport::Concern

  def event
    Event.find(event_id)
  end

  def event?
    event_id && event
  end

  def event=(event)
    self.event_id = event.id
  end

end