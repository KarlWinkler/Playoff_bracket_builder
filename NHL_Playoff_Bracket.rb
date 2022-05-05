require_relative "a_team"
require_relative "factory"

# help message
$helpMessageModeOne = <<EOM
Help Menu
============================================================
slots start from top left and go top to bottom, then by round

entering a team name that is not the same as a following command will insert it into the 
current index and increment to the next slot automatically

h -> displays this menu

m -> move to an index in the first round 1-16 (overflow will circle around)

r -> replace team at the current index

i -> insert team at an index 

mm -> move to a matchup (overflow will circle around)

1 -> select top team as the winner in the currently selected match

2 -> select bottom team as the winner in the currently selected match 

i1 -> select top team as the winner in the indexed match

i2 -> select bottom team as the winner in the indexed match

p -> prints the current bracket

nr -> advance to next round 

pf -> prints to file

s -> saves the current bracket

exit -> saves the current bracket and closes the program 

reset -> resets the braket so everything is empty
=============================================================
EOM

$teamsConfFile = "teams"
$bracketSaveName = "nhl.bracket"
$numOfFirstRoundTeams = 16
$numOfMatchups = 15

# simple global state tracking variables
$mode = 1 #tracks the editing mode # depricated (I think)
$index = 1 #tracks current index
$match = 1

def main

  $teams = Factory.createTeams(Factory.createTeamsBuilder($teamsConfFile))
  $bracket = Factory.createBracket(Factory.createBracketBuilder($bracketSaveName))
  $bracketUpdater = Factory.createBracketUpdater($bracket)
  $bracketPrinter = Factory.createBracketPrinter($bracket)
  $bracketSaver = Factory.createBracketSaver($bracket)
  $validator = Factory.createTeamsValidator($teams)

  #app loop
  loop do
    puts "\nset up the starting 16 playoff bound teams and the matchups"
    puts "current index = #{$index}"
    puts "current match = #{$match}"
    print "enter h to view the help menu: "
    input = gets.to_s.chomp.downcase
    
    case input
    when "m"
      inx = getInx($numOfFirstRoundTeams)
      if inx != -1 #did getInx return valid
        $index = inx
      end
    when "mm"
      inx = getInx($numOfMatchups)
      if inx != -1 
        $match = inx
      end
    when "r"
      team = getTeamName
      if team != -1
        $bracketUpdater.addTeamAt($index - 1, team)
      end
    when "i"
      team = getTeamName
      if team != -1
        inx = getInx(numOfFirstRoundTeams)
        if inx != -1
          $bracketUpdater.addTeamAt(inx - 1, team)
        end
      end
    when "1"
      $bracketUpdater.setWinner($match - 1, 0)
      $match += 1
    when "2"
      $bracketUpdater.setWinner($match - 1, 1)
      $match += 1
    when "i1"
      inx = getInx(numOfMatchups)
      if inx != -1
        $bracketUpdater.setWinner(inx - 1, 0)
      end
    when "i2"
      inx = getInx(numOfMatchups)
      if inx != -1
        $bracketUpdater.setWinner(inx - 1, 1)
      end
    when "p"
      $bracketPrinter.print
    when "pf"
      print "file name: "
      file = gets.to_s.chomp
      $bracketPrinter.printf(file)
    when "h"
      puts $helpMessageModeOne 
    when "s"
      $bracketSaver.save($bracketSaveName)
    when "next"
      $mode += 1
    when "exit"
      $bracketSaver.save($bracketSaveName)
      exit
    when "reset"
      #reset bracket by making a new one (should probably be a method in the bracket class)
      $bracketUpdater = Bracket.new([])
    else
      team = tryTeamName(input)
      if team != -1
        $bracketUpdater.addTeamAt($index - 1, team)
        $index += 1
        puts "inserted #{team}"
      else
        puts "not a team"
      end      
    end
  end
end

# prompts for and gets the team name from the user 
# returns the name from the team object or -1 if the function
# is cancelled
def getTeamName
  # try until the user quits or enters a valid name
  loop do
    print "team name or exit to cancel: "
    teamIn = gets.to_s.downcase.chomp

    # different ways to quit
    if teamIn == "exit" || teamIn == "cancel" || teamIn == "quit"
      break
    end
    team = tryTeamName(teamIn)
    if team != -1
      return team
    end
  end
  return -1
end

# same as getTeamName but for the index
# max int makes the input loop over itself so that the index never
# goes out of bounds
def getInx(max)
  loop do
    print "index or -1 to cancel: "
    inx = gets.to_s.chomp.downcase
    if inx == "exit" || inx == "cancel" || inx == "quit"
      return -1
    end
    inx = inx.to_i
    if inx < 0
      return -1
    end
    if inx > max
      return inx % max + 1
    else
      return inx
    end
  end
end

def tryTeamName(name)
  return $validator.validate(name)
end

#because I have to have functions declaired before they are called
main


