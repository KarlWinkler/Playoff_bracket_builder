

# holds a bracket string that can be saved to a file
class Bracket

  # takes a bracket template built by the 
  # bracket builder object and turns it into a bracket object
  def initialize(builderInterface)

    @teams = []
    @winner = []

    templateToBracket(builderInterface.build)
  end

  # 
  def templateToBracket(bracketTemplate)
    i = 0;
    bracketTemplate.each do |team|
      if i < 16
        @teams[i] = team
      else
        @winner[i - 16] = team.to_i
      end
      i += 1
    end
    while i < 32
      if i < 16
        @teams[i] ="___"
      else
        @winner[i - 16] = -1
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
end
