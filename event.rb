class Event

  def initialize(message, index, match)
    @message = message
    @index = index
    @match = match
  end

  def getMessage
    return @message
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
    return @match
  end

  def setMatch(m)
    @match = m
  end
end