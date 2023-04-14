module BracketSaver
  #saves the bracket as a template to a file
  def save(file_name: 'nhl.bracket')
    writer = File.new(file_name, 'w')
    @teams.each do |team|
      writer.puts team
    end
    @winners.each do |team|
      writer.puts team
    end
    writer.close
  end
end
