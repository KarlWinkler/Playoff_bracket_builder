require_relative "Interfaces/bracketInterface"
require_relative "Interfaces/teamsInterface"
require_relative "Interfaces/builderInterface"
require_relative "Interfaces/saveInterface"
require_relative "Interfaces/updaterInterface"
require_relative "Interfaces/printerInterface"
require_relative "Interfaces/validatorInterface"
require_relative "Interfaces/eventHandlerInterface"
require_relative "Interfaces/UIInterface"

require_relative "bracket"
require_relative "teams"
require_relative "teamsBuilder"
require_relative "bracketSaver"
require_relative "bracketBuilder"
require_relative "bracketUpdater"
require_relative "bracketPrinter"
require_relative "teamsValidator"
require_relative "inputEventHandler"
require_relative "UI"

# responsable for creating all of the objects
# so they can be swaped out later

class Factory

  def self.createBracket(builder)
    return BracketInterface.new(Bracket.new(builder))
  end  

  def self.createBracketBuilder(fileName)
    return BuilderInterface.new(BracketBuilder.new(fileName))
  end

  def self.createBracketSaver(bracket)
    return SaveInterface.new(BracketSaver.new(bracket))
  end

  def self.createBracketPrinter(bracket)
    return PrinterInterface.new(BracketPrinter.new(bracket))
  end

  def self.createBracketUpdater(bracket)
    return UpdaterInterface.new(BracketUpdater.new(bracket))
  end

  def self.createTeams(builder)
    return TeamsInterface.new(Teams.new(builder))
  end

  def self.createTeamsBuilder(fileName)
    return BuilderInterface.new(TeamsBuilder.new(fileName))
  end

  def self.createTeamsValidator(teams)
    return ValidatorInterface.new(TeamsValidator.new(teams))
  end

  def self.createEventHandler(standardMessages, updater, saver, printer, validator, bracket)
    return EventHandlerInterface.new(InputEventHandler.new(standardMessages, updater, saver, printer, validator, bracket))
  end

  def self.createUI(eventHandler)
    return UIInterface.new(UI.new(eventHandler))
  end

end
