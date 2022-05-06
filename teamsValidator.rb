class TeamsValidator

  def initialize(teams)
    @teamsList = teams.getTeamsList
  end

  # checks if a team name is valid
  # returns the resulting teams name if valid 
  # else returns -1

  # a team name is valid if it matches one of the 
  # names for a team
  def validate(name)
    @teamsList.each do |team|
      if team.match(name)
       return team.name
      end
    end
    return -1
  end
end