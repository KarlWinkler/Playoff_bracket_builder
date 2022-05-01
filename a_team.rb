class A_team
  def initialize(namesIn)
    #array of strings
    @names = []
    namesIn.each do |n|
      @names.push(n.downcase.chomp)
    end
  end
    
  def match(nameIn)
    return @names.include?(nameIn)
  end

  def name
    return @names[0].upcase
  end
end  
