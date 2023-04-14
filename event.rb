class Event
  def initialize(message, index, match)
    @message = message
    @index = index
    @match = match
  end

  def getMessage
    @message
  end

  def setMessage(m)
    @message = m
  end

  def getIndex
    return @index
  end

  def setIndex(inx)
    @index = inx
  end

  def getMatch
    @match
  end

  def setMatch(m)
    @match = m
  end
end
