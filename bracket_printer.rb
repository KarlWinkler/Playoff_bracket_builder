module BracketPrinter
  def print
    r = "\033[0m" # reset escape code

    %(
      #{get_colour(0)}#{@teams[0]}#{r}                           #{get_colour(8)}#{@teams[8]}#{r}
      #{get_colour(1)}#{@teams[1]}#{r}                           #{get_colour(9)}#{@teams[9]}#{r}
            #{get_colour(16)}#{get_winner(0)}#{r}               #{get_colour(20)}#{get_winner(4)}#{r}
            #{get_colour(17)}#{get_winner(1)}#{r}               #{get_colour(21)}#{get_winner(5)}#{r}
      #{get_colour(2)}#{@teams[2]}#{r}                           #{get_colour(10)}#{@teams[10]}#{r}
      #{get_colour(3)}#{@teams[3]}#{r}                           #{get_colour(11)}#{@teams[11]}#{r}
                #{get_colour(24)}#{get_winner(8)}#{r}  #{get_colour(28)}#{get_winner(12)}#{r}  #{get_colour(26)}#{get_winner(10)}#{r}
                #{get_colour(25)}#{get_winner(9)}#{r}  #{get_colour(29)}#{get_winner(13)}#{r}  #{get_colour(27)}#{get_winner(11)}#{r} 
      #{get_colour(4)}#{@teams[4]}#{r}                           #{get_colour(12)}#{@teams[12]}#{r}
      #{get_colour(5)}#{@teams[5]}#{r}                           #{get_colour(13)}#{@teams[13]}#{r}
            #{get_colour(18)}#{get_winner(2)}#{r}               #{get_colour(22)}#{get_winner(6)}#{r}
            #{get_colour(19)}#{get_winner(3)}#{r}               #{get_colour(23)}#{get_winner(7)}#{r}
      #{get_colour(6)}#{@teams[6]}#{r}                           #{get_colour(14)}#{@teams[14]}#{r}
      #{get_colour(7)}#{@teams[7]}#{r}                           #{get_colour(15)}#{@teams[15]}#{r})
  end

  def printf(file)
    writer = File.new(file, 'w')

    writer.puts %(
      #{@teams[0]}                           #{@teams[8]}
      #{@teams[1]}                           #{@teams[9]}
          #{get_winner(0)}                 #{get_winner(4)}
          #{get_winner(1)}                 #{get_winner(5)}
      #{@teams[2]}                           #{@teams[10]}
      #{@teams[3]}                           #{@teams[11]}
                #{get_winner(8)}  #{get_winner(12)}  #{get_winner(10)}
                #{get_winner(9)}  #{get_winner(13)}  #{get_winner(11)}
      #{@teams[4]}                           #{@teams[12]}
      #{@teams[5]}                           #{@teams[13]}
          #{get_winner(2)}                 #{get_winner(6)}
          #{get_winner(3)}                 #{get_winner(7)}
      #{@teams[6]}                           #{@teams[14]}
      #{@teams[7]}                           #{@teams[15]}
    )
    writer.close
  end

  def get_colour(inx)
    if @winners[inx / 2].to_i == inx % 2
      return "\033[30m\033[48;5;214m" if inx / 2 == 14

      "\033[30m\033[48;5;34m"
    elsif @winners[inx / 2].to_i >= 0
      "\033[30m\033[48;5;196m"
    else
      "\033[46m"
    end
  end

  def get_winner(match)
    return '___' if @winners[match] == -1

    return @teams[(match * 2 + @winners[match].to_i)] if match < 8

    get_winner(((match - 8) * 2 + @winners[match].to_i))
  end
end
