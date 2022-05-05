# holds a bracket string that can be saved to a file
class BracketInterface

  # takes a bracket template built by the 
  # bracket builder object and turns it into a bracket object
  def initialize(bracket)
    @bracket = bracket
  end

  def setTeams(teams)
    return @bracket.setTeams(teams)
  end

  def setTeamAt(inx, value)
    return @bracket.setTeamAt(inx, value)
  end

  def setWinnerAt(inx, value)
    return @bracket.setWinnerAt(inx, value)
  end

  def setWinner(winner)
    return @bracket.setWinner(winner)
  end

  def getTeams
    return @bracket.getTeams
  end

  def getWinners
    return @bracket.getWinners
  end

  def templateToBracket(bracketTemplate)
    return @bracket.templateToBracket
  end
end
