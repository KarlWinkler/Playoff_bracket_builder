class Bracket

  def initialize(initBracket)

    @teams = []
    @currentIndex = 0
    @bracket = ""
    i = 0;
    initBracket.each do |team|
      @teams[i] = team
      i += 1
    end
    while i < 29
      @teams[i] ="___"
      i += 1
    end

    update
  end

  def update

    @bracket = <<EOM
    #{@teams[0]}                           #{@teams[8]}
    #{@teams[1]}                           #{@teams[9]}
         #{@teams[16]}                 #{@teams[20]}
         #{@teams[17]}                 #{@teams[21]}
    #{@teams[2]}                           #{@teams[10]}
    #{@teams[3]}                           #{@teams[11]}
              #{@teams[24]}       #{@teams[26]}
              #{@teams[25]}  #{@teams[28]}  #{@teams[27]} 
    #{@teams[4]}                           #{@teams[12]}
    #{@teams[5]}                           #{@teams[13]}
         #{@teams[18]}                 #{@teams[22]}
         #{@teams[19]}                 #{@teams[23]}
    #{@teams[6]}                           #{@teams[14]}
    #{@teams[7]}                           #{@teams[15]}
EOM
  end
  
  def save
    writer = File.new("nhl.bracket", "w")
    @teams.each do |team|
      writer.puts "#{team}"
    end
    writer.close
  end

  def print
    update
    puts @bracket 
  end

  def printf(file)
    update
    writer = File.new(file, "w")
    writer.puts @bracket
    writer.close
  end

  def addTeam(teamName)
    @teams[@currentIndex] = teamName
    @currentIndex += 1
  end

  def addTeamAt(teamName, inx)
    @teams[inx] = teamName
  end

  def removeTeam(inx)
    @teams[inx] = "___"
  end
end
