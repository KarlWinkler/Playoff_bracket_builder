require_relative "Interfaces/printerInterface"

class BracketPrinter < PrinterInterface
 
	def initialize(bracketInterface)
    @teams = bracketInterface.getTeams
    @winner = bracketInterface.getWinners
	end

  def print
    r = "\033[0m" #reset escape code

    bracket = <<EOM
    #{getColour(0)}#{@teams[0]}#{r}                           #{getColour(8)}#{@teams[8]}#{r}
    #{getColour(1)}#{@teams[1]}#{r}                           #{getColour(9)}#{@teams[9]}#{r}
         #{getColour(16)}#{getWinner(0)}#{r}                 #{getColour(20)}#{getWinner(4)}#{r}
         #{getColour(17)}#{getWinner(1)}#{r}                 #{getColour(21)}#{getWinner(5)}#{r}
    #{getColour(2)}#{@teams[2]}#{r}                           #{getColour(10)}#{@teams[10]}#{r}
    #{getColour(3)}#{@teams[3]}#{r}                           #{getColour(11)}#{@teams[11]}#{r}
              #{getColour(24)}#{getWinner(8)}#{r}  #{getColour(28)}#{getWinner(12)}#{r}  #{getColour(26)}#{getWinner(10)}#{r}
              #{getColour(25)}#{getWinner(9)}#{r}  #{getColour(29)}#{getWinner(13)}#{r}  #{getColour(27)}#{getWinner(11)}#{r} 
    #{getColour(4)}#{@teams[4]}#{r}                           #{getColour(12)}#{@teams[12]}#{r}
    #{getColour(5)}#{@teams[5]}#{r}                           #{getColour(13)}#{@teams[13]}#{r}
         #{getColour(18)}#{getWinner(2)}#{r}                 #{getColour(22)}#{getWinner(6)}#{r}
         #{getColour(19)}#{getWinner(3)}#{r}                 #{getColour(23)}#{getWinner(7)}#{r}
    #{getColour(6)}#{@teams[6]}#{r}                           #{getColour(14)}#{@teams[14]}#{r}
    #{getColour(7)}#{@teams[7]}#{r}                           #{getColour(15)}#{@teams[15]}#{r}
EOM

  puts bracket
  end

  def printf(file)
    writer = File.new(file, "w")

    writer.puts <<EOM
    #{@teams[0]}                           #{@teams[8]}
    #{@teams[1]}                           #{@teams[9]}
         #{getWinner(0)}                 #{getWinner(4)}
         #{getWinner(1)}                 #{getWinner(5)}
    #{@teams[2]}                           #{@teams[10]}
    #{@teams[3]}                           #{@teams[11]}
              #{getWinner(8)}  #{getWinner(12)}  #{getWinner(10)}
              #{getWinner(9)}  #{getWinner(13)}  #{getWinner(11)} 
    #{@teams[4]}                           #{@teams[12]}
    #{@teams[5]}                           #{@teams[13]}
         #{getWinner(2)}                 #{getWinner(6)}
         #{getWinner(3)}                 #{getWinner(7)}
    #{@teams[6]}                           #{@teams[14]}
    #{@teams[7]}                           #{@teams[15]}
EOM
    writer.close
  end

  def getColour(inx)
    if @winner[inx / 2].to_i == inx % 2
      if inx/2 == 14
        return "\033[30m\033[48;5;214m"
      end
      return "\033[30m\033[48;5;34m"
    elsif @winner[inx / 2].to_i >= 0
      return "\033[30m\033[48;5;196m"
    else
      return "\033[46m"
    end
  end

  def getWinner(match)
    if @winner[match] == -1
      return "___"
    end
    if match < 8
      return @teams[(match * 2 + @winner[match].to_i)]
    else
      return getWinner(((match - 8) * 2 + @winner[match].to_i))
    end
  end

end