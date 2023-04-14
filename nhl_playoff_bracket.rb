require_relative 'team'
require_relative 'standardMessages'
require_relative 'factory'

teams_conf_file = 'teams'

# creating logic and data objects
teams = Factory.createTeams(Factory.createTeamsBuilder(teams_conf_file))
bracket = Factory.createBracket(Factory.createBracketBuilder(file_name: 'nhl.bracket'))
validator = Factory.createTeamsValidator(teams)

# creating view objects
event_handler = Factory.createEventHandler(StandardMessages.new, validator, bracket)
user_interface = Factory.createUI(event_handler)

# run program
user_interface.run
