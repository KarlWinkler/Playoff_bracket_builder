require_relative "Interfaces/eventHandlerInterface"

class InputEventHandler < EventHandlerInterface

  def initialize(standardMessages, updater, saver, printer, validator, bracket)
    @standardMessages = standardMessages
    @updater = updater
    @saver = saver
    @printer = printer
    @validator = validator
    @bracket = bracket
    @bracketSaveName = "nhl.bracket"
  end

  def getResponse(input, index, match)
    case input

    when "m"
      inx = getInx(@bracket.getNumFirstRoundTeams)
      if inx != -1 #did getInx return valid
        index = inx
        return "moved to index #{inx}"
      end
    when "mm"
      inx = getInx(@bracket.getNumMatchups)
      if inx != -1 
        match = inx
        return "moved to match #{inx}"
      end
    when "r"
      team = getTeamName
      if team != -1
        @updater.addTeamAt(index - 1, team)
        return "#{team} set at index #{index}"
      end
    when "i"
      team = getTeamName
      if team != -1
        inx = getInx(@bracket.getNumOfFirstRoundTeams)
        if inx != -1
          @updater.addTeamAt(inx - 1, team)
          return "#{team} set at index #{inx}"
        end
      end
    when "1"
      @updater.setWinner(match - 1, 0)
      match += 1
      return "winner set to 1"
    when "2"
      @updater.setWinner(match - 1, 1)
      match += 1
      return "winner set to 2"
    when "i1"
      inx = getInx(@bracket.getNumMatchups)
      if inx != -1
        @updater.setWinner(inx - 1, 0)
        return "winner of matchup #{inx} set to 1"
      end
    when "i2"
      inx = getInx(@bracket.getNumMatchups)
      if inx != -1
        @updater.setWinner(inx - 1, 1)
        return "winner of matchup #{inx} set to 2"
      end
    when "p"
      return @printer.print
    when "pf"
      print "file name: "
      file = gets.to_s.chomp
      @printer.printf(file)
      return "printed to file: #{file}"
    when "h"
      return @standardMessages.helpMessage 
    when "s"
      @saver.save(@bracketSaveName)
      return "saved"
    when "exit"
      @saver.save(@bracketSaveName)
      
      exit
    when "reset"
      #reset bracket by making a new one (should probably be a method in the bracket class)
      @updater = Bracket.new([])
    else
      team = tryTeamName(input)
      if team != -1
        @updater.addTeamAt(index - 1, team)
        index += 1
        return "inserted #{team}"
      else
        return "not a team"
      end
    end
    return 1
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
    return @validator.validate(name)
  end
end