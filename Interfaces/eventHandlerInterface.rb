class EventHandlerInterface
  def initialize(eventHandler)
    @eventHandler = eventHandler
  end

  def getResponse(event, inx, match)
    @eventHandler.getResponse(event, inx, match)
  end
end