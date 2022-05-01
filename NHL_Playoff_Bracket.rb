require_relative "a_team"
require_relative "bracket"

#to make editing in the future eaiser
if File.exist?("nhl.bracket")  
  fromFile = []
  reader = File.open("nhl.bracket") do |teamsList|
    teamsList.each do |team|
      fromFile.push(team.to_s.chomp)
    end
  end 

  $bracket = Bracket.new(fromFile)

else

  $bracket = Bracket.new([])

end

#make sure the teams file exists
if !File.exist?("teams")
  puts "please make a test file of all teams currently in the NHL \nthis list is used to check if the input matches a valid team in the league"
  exit
end

#build the resources from the teams file
$teamsList = []
reader = File.open("teams") do |team|
  team.each do |names|
    $teamsList.push(A_team.new(names.split(", ")))
  end
end
reader.close

# help message for the first round menu (I will make one that should encompase the other menues seperate)
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

# simple global state tracking variables
$mode = 1 #tracks the editing mode
$index = 1 #tracks current index
$match = 1

#app loop
def main
  loop do
    puts "\nset up the starting 16 playoff bound teams and the matchups"
    puts "current index = #{$index}"
    puts "current match = #{$match}"
    print "enter h to view the help menu: "
    input = gets.to_s.chomp.downcase
    
    case input
    when "m"
      inx = getInx(16)
      if inx != -1 #did getInx return valid
        $index = inx
      end
    when "mm"
      inx = getInx(15)
      if inx != -1 
        $match = inx
      end
    when "r"
      team = getTeamName
      if team != -1
        $bracket.addTeamAt(team, $index - 1)
      end
    when "i"
      team = getTeamName
      inx = getInx(16)
      if team != -1 || inx != -1
        puts "#{inx}"
        $bracket.addTeamAt(team, inx - 1)
      end
    when "1"
      $bracket.setWinner($match - 1, 0)
      $match += 1
    when "2"
      $bracket.setWinner($match - 1, 1)
      $match += 1
    when "i1"
      inx = getInx(15)
      if inx != -1
        $bracket.setWinner(inx - 1, 0)
      end
    when "i2"
      inx = getInx(15)
      if inx != -1
        $bracket.setWinner(inx - 1, 1)
      end
    when "p"
      $bracket.print
    when "pf"
      print "file name: "
      file = gets.to_s.chomp
      $bracket.printf(file)
    when "h"
      puts $helpMessageModeOne 
    when "s"
      $bracket.save
    when "next"
      $mode += 1
    when "exit"
      $bracket.save
      exit
    when "reset"
      #reset bracket by making a new one (should probably be a method in the bracket class)
      $bracket = Bracket.new([])
    else
      team = tryTeamName(input)
      if team != -1
        $bracket.addTeamAt(team, $index - 1)
        $index += 1
        puts "inserted #{team}"
      else
        puts "not a team"
      end      
    end
  end
end

#prompts for and gets the team name from the user 
#returns the name from the team object or -1 if the function
#is cancelled
def getTeamName
  loop do
    print "team name or exit to cancel: "
    teamIn = gets.to_s.downcase.chomp
    #generous with what you can quit with (I hate when it is strict)
    if teamIn == "exit" || teamIn == "cancel" || teamIn == "quit"
      return -1
    end
    $teamsList.each do |team|
      if team.match(teamIn)
        return team.name
      end
    end
  end
  return -1
end

#same as getTeamName but for the index
#only thing is for the max int that is allowed for the user so that some users 
#who want to be special are accounted for
def getInx(max)
  loop do
    print "index or -1 to cancel: "
    inx = gets.to_s.chomp.downcase
    #in case user wants to it wont be to strange
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

#more lenient test for a team name (only tries once)
def tryTeamName(name)
  $teamsList.each do |team|
    if team.match(name)
      return team.name
    end
  end
  return -1
end

#because I have to have functions declaired before they are called
main


