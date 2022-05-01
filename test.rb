require_relative "bracket"

teams = ["CGY", "DAL", "LAK", "EDM", "COL", "NSH", "MIN", "STL", "FLA", "WSH", "TOR", "TBL", "CAR", "BOS", "PIT", "NYR"]

bracket =  Bracket.new

teams.each do |team|
  bracket.addTeam(team)
end
puts bracket.print

