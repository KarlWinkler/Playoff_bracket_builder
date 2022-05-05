require_relative "bracket"
require_relative "teams"
require_relative "teamsBuilder"
require_relative "bracketSaver"
require_relative "bracketBuilder"
require_relative "bracketUpdater"
require_relative "bracketPrinter"
require_relative "teamsValidator"

# responsable for creating all of the objects
# so they can be swaped out later

class Factory

  def self.createBracket(builder)
    return Bracket.new(builder)
  end  

  def self.createBracketBuilder(fileName)
    return BracketBuilder.new(fileName)
  end

  def self.createBracketSaver(bracket)
    return BracketSaver.new(bracket)
  end

  def self.createBracketPrinter(bracket)
    return BracketPrinter.new(bracket)
  end

  def self.createBracketUpdater(bracket)
    return BracketUpdater.new(bracket)
  end

  def self.createTeams(builder)
    return Teams.new(builder)
  end

  def self.createTeamsBuilder(fileName)
    return TeamsBuilder.new(fileName)
  end

  def self.createTeamsValidator(teams)
    return TeamsValidator.new(teams)
  end

end
