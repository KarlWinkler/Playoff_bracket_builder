require_relative "Interfaces/bracketInterface"

# holds a bracket string that can be saved to a file
class Bracket < BracketInterface

  # takes a bracket template built by the 
  # bracket builder object and turns it into a bracket object
  def initialize(builderInterface)
    @numOfFirstRoundTeams = 16
    @numOfMatchups = 15

    @teams = []
    @winner = []

    templateToBracket(builderInterface.build)
  end

  # 
  def templateToBracket(bracketTemplate)
    i = 0;
    bracketTemplate.each do |team|
      if i < @numOfFirstRoundTeams
        @teams[i] = team
      else
        @winner[i - @numOfFirstRoundTeams] = team.to_i
      end
      i += 1
    end
    while i < @numOfFirstRoundTeams  * 2
      if i < @numOfFirstRoundTeams
        @teams[i] ="___"
      else
        @winner[i - @numOfFirstRoundTeams] = -1
      end
      i += 1
    end
  end

  def setTeams(teams)
    @teams = teams
  end

  def setTeamAt(inx, value)
    @teams[inx] = value.to_s
  end

  def setWinnerAt(inx, value)
    @winner[inx] = value.to_i
  end

  def setWinner(winner)
    @winner = winner
  end

  def getTeams
    return @teams
  end

  def getWinners
    return @winner
  end

  def getNumMatchups
    return @numOfMatchups
  end

  def getNumFirstRoundTeams
    return @numOfFirstRoundTeams
  end
end
