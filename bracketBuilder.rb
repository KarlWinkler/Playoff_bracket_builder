class BracketBuilder
  def initialize(file_name: 'nhl.bracket')
    @file_name = file_name
  end

  # builds the bracket from the given conf file
  def build
    bracket_template = []

    if File.exist?(@file_name)
      File.open(@file_name) do |teams_list|
        teams_list.each do |team|
          bracket_template.push(team.to_s.chomp)
        end
      end
    end

    bracket_template
  end
end
