class Team
  def initialize(names_in)
    # array of strings
    @names = []
    names_in.each do |n|
      @names.push(n.downcase.chomp)
    end
  end

  def match(name_in)
    @names.include?(name_in)
  end

  def name
    @names[0].upcase
  end
end
