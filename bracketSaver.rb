class BracketSaver

  def initialize(bracket)
    @winner = bracket.getWinners
    @teams = bracket.getTeams
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