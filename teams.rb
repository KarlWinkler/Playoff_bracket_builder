require_relative "teamsBuilder"

# Teams object that holds the teams list
# used to handle team name checks
class Teams

  def initialize(builder)
    @teamsList = builder.build
  end

  def getTeamsList
    return @teamsList
  end

end