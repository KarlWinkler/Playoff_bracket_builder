class EventHandlerInterface
  def initialize(eventHandler)
    @eventHandler = eventHandler
  end

  def get_response(event, inx, match)
    @eventHandler.get_response(event, inx, match)
  end
end
