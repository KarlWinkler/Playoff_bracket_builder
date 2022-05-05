# Teams object that holds the teams list
# used to handle team name checks
class TeamsInterface

  def initialize(teams)
    @teams = teams
  end

  def getTeamsList
    return @teams.getTeamsList
  end

end