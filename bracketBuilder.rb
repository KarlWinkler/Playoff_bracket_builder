class BracketBuilder 
  def initialize(fileName)
    @fileName = fileName #default: "nhl.bracket"
  end

  # builds the bracket from the given conf file
  def build

    bracketTemplate = []

    if File.exist?(@fileName)  
      reader = File.open(@fileName) do |teamsList|
        teamsList.each do |team|
          bracketTemplate.push(team.to_s.chomp)
        end
      end 
    end

    return bracketTemplate
  end
end
