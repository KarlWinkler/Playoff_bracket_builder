require_relative "a_team"
require_relative "standardMessages"
require_relative "factory"


teamsConfFile = "teams"

#creating logic and data objects
teams = Factory.createTeams(Factory.createTeamsBuilder(teamsConfFile))
bracket = Factory.createBracket(Factory.createBracketBuilder("nhl.bracket"))
bracketUpdater = Factory.createBracketUpdater(bracket)
bracketPrinter = Factory.createBracketPrinter(bracket)
bracketSaver = Factory.createBracketSaver(bracket)
validator = Factory.createTeamsValidator(teams)

#creating view objects
eventHandler = Factory.createEventHandler(StandardMessages.new, bracketUpdater, bracketSaver, bracketPrinter, validator, bracket)
userInterface = Factory.createUI(eventHandler)

#run program
userInterface.run

