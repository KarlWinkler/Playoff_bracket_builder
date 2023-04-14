module BracketUpdater
  def addTeamAt(inx, teamName)
    @bracket.setTeamAt(inx, teamName)
  end

  def removeTeam(inx)
    @bracket.setTeamAt(inx, "___")
  end

  def setWinner(inx, winner)
    @bracket.setWinnerAt(inx, winner)
  end
end
