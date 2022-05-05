require_relative "Interfaces/builderInterface"

#builds the teams list from the input file
class TeamsBuilder < BuilderInterface

  def initialize(fileName)
    @fileName = fileName #default: "teams"
  end

  # translates the config file into an array that 
  # contains each team and their alternative names
  # for comparing to user input

  def build
    
    #if false it exits the program
    checkConfExists

    teamsList = []

    reader = File.open(@fileName) do |team|
      team.each do |teamNames|
        teamsList.push(A_team.new(teamNames.split(", ")))
      end
    end
    reader.close

    return teamsList
  end

  # make sure the teams file exists
  # otherwise alert user to build the file
  def checkConfExists
    if !File.exist?(@fileName)
      puts "The file #{@fileName} does not exist,"
      puts "This file is used to check if teams are valid"
      puts "the first string on a line will be used in the braket"
      puts "all following names will be used as alternates to validate"
      puts "a user entering a name for a team"
      exit
    end
  end
end