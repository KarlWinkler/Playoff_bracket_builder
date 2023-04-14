require_relative "event"

class InputEventHandler
  def initialize(standard_messages, validator, bracket)
    @standard_messages = standard_messages
    @validator = validator
    @bracket = bracket
  end

  def get_response(event_in)
    input = event_in.getMessage
    index = event_in.getIndex
    match = event_in.getMatch

    if quit_strings.include? input
      @bracket.save
      @standard_messages.exitMessage
      exit
    end

    case input
    when 'm'
      inx = get_inx(@bracket.num_of_first_round_teams)
      if inx != -1 # did get_inx return valid
        index = inx
        return Event.new("moved to index #{inx}", index, match)
      end
    when 'mm'
      inx = get_inx(@bracket.num_of_matchups)
      if inx != -1
        match = inx
        return Event.new("moved to match #{inx}", index, match)
      end
    when 'r'
      team = team_name
      if team != -1
        @bracket.set_team_at(index - 1, team)
        return Event.new("#{team} set at index #{index}", index, match)
      end
    when 'i'
      team = team_name
      if team != -1
        inx = get_inx(@bracket.num_of_first_round_teams)
        if inx != -1
          @bracket.set_team_at(inx - 1, team)
          return Event.new("#{team} set at index #{inx}", index, match)
        end
      end
    when '1'
      @bracket.set_winner_at(match - 1, 0)
      match += 1
      return Event.new('winner set to 1', index, match)
    when '2'
      @bracket.set_winner_at(match - 1, 1)
      match += 1
      return Event.new('winner set to 2', index, match)
    when 'i1'
      inx = get_inx(@bracket.num_of_matchups)
      if inx != -1
        @bracket.set_winner_at(inx - 1, 0)
        return Event.new("winner of matchup #{inx} set to 1", index, match)
      end
    when 'i2'
      inx = get_inx(@bracket.num_of_matchups)
      if inx != -1
        @bracket.set_winner_at(inx - 1, 1)
        return Event.new("winner of matchup #{inx} set to 2", index, match)
      end
    when 'p'
      return Event.new(@bracket.print, index, match)
    when 'pf'
      print 'file name: '
      file = gets.to_s.chomp
      @bracket.printf(file)
      return Event.new("printed to file: #{file}", index, match)
    when 'h'
      return Event.new(@standard_messages.helpMessage, index, match)
    when 's'
      @bracket.save
      return Event.new('saved', index, match)
    when 'reset'
      # reset bracket by making a new one (should probably be a method in the bracket class)
      @bracket.reset
      return Event.new('bracket reset', 1, 1)
    else
      team = team_name?(input)
      return Event.new('not a team', index, match) unless team != -1

      @bracket.set_team_at(index - 1, team)
      index += 1
      return Event.new("inserted #{team}", index, match)
    end
    1
  end

  # prompts for and gets the team name from the user 
  # returns the name from the team object or -1 if the function
  # is cancelled
  def team_name
    # try until the user quits or enters a valid name
    loop do
      print 'team name or exit to cancel: '
      team_in = gets.to_s.downcase.chomp

      # different ways to quit
      break if quit_strings.include? team_in

      team = team_name?(team_in)
      return team if team != -1
    end
    -1
  end

  # same as team_name but for the index
  # max int makes the input loop over itself so that the index never
  # goes out of bounds
  def get_inx(max)
    print 'index or -1 to cancel: '

    inx = gets.to_s.chomp.downcase
    return -1 if quit_strings.include?(inx) || inx.to_i.negative?

    inx = inx.to_i
    return inx % max + 1 if inx > max

    inx
  end

  def team_name?(name)
    @validator.validate(name)
  end

  def quit_strings
    %w[exit cancel quit q]
  end
end
