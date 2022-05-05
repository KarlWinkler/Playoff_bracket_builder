class UpdaterInterface

  def initialize(updater)
    @updater = updater
  end

  def addTeamAt(inx, teamName)
    return @updater.addTeamAt(inx, teamName)
  end

  def removeTeam(inx)
    return @updater.removeTeam(inx)
  end

  def setWinner(inx, winner)
    return @updater.setWinner(inx, winner)
  end

end