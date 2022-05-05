class BracketSaver

  def initialize(bracketInterface)
    @winner = bracketInterface.getWinners
    @teams = bracketInterface.getTeams
  end
  
  #saves the bracket as a template to a file
  def save(fileName)
    writer = File.new(fileName, "w")
    @teams.each do |team|
      writer.puts "#{team}"
    end
    @winner.each do |team|
      writer.puts "#{team}"
    end
    writer.close
  end
end