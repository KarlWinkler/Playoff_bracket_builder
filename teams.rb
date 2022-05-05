require_relative "Interfaces/teamsInterface"

# Teams object that holds the teams list
# used to handle team name checks
class Teams < TeamsInterface

  def initialize(builder)
    @teamsList = builder.build
  end

  def getTeamsList
    return @teamsList
  end

end