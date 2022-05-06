require_relative "Interfaces/UIInterface"

class UI < UIInterface
  def initialize(eventHandler)
    @eventHandler = eventHandler
    @index = 1
    @match = 1
  end

  def run    
    loop do
      puts "\nset up the starting 16 playoff bound teams and the matchups"
      puts "current index = #{@index}"
      puts "current match = #{@match}"
      print "enter h to view the help menu: "
      input = gets.to_s.chomp.downcase
      puts @eventHandler.getResponse(input, @index, @match)     
    end
  end
end