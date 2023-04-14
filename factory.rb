require_relative "bracket"
require_relative "teams"
require_relative "teamsBuilder"
require_relative "bracketBuilder"
require_relative "teamsValidator"
require_relative "inputEventHandler"
require_relative "UI"

require_relative 'bracket_saver'
require_relative 'bracket_printer'
require_relative 'bracket_updater'

# responsable for creating all of the objects
# so they can be swaped out later

class Factory

  def self.createBracket(builder)
    Bracket.new(builder)
  end

  def self.createBracketBuilder(file_name:)
    BracketBuilder.new(file_name: file_name)
  end

  def self.createTeams(builder)
    Teams.new(builder)
  end

  def self.createTeamsBuilder(fileName)
    TeamsBuilder.new(fileName)
  end

  def self.createTeamsValidator(teams)
    TeamsValidator.new(teams)
  end

  def self.createEventHandler(standardMessages, validator, bracket)
    InputEventHandler.new(standardMessages, validator, bracket)
  end

  def self.createUI(eventHandler)
    UI.new(eventHandler)
  end
end
