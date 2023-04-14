require_relative 'bracket_saver'
require_relative 'bracket_printer'
require_relative 'bracket_updater'

class Bracket
  include BracketSaver
  include BracketPrinter
  include BracketUpdater

  # takes a bracket template built by the
  # bracket builder object and turns it into a bracket object
  def initialize(builder_interface)
    @num_of_first_round_teams = 16
    @num_of_matchups = 15

    @teams = []
    @winners = []

    template_to_bracket(builder_interface.build)
  end

  def template_to_bracket(bracket_template)
    process_template(bracket_template)
    i = bracket_template.length

    while i < @num_of_first_round_teams * 2
      if i < @num_of_first_round_teams
        @teams[i] = '___'
      else
        @winners[i - @num_of_first_round_teams] = -1
      end
      i += 1
    end
  end

  def process_template(bracket_template)
    bracket_template.each_with_index do |team, index|
      if index < @num_of_first_round_teams
        @teams[index] = team
      else
        @winners[index - @num_of_first_round_teams] = team.to_i
      end
    end
  end

  attr_accessor :teams, :winners, :num_of_matchups, :num_of_first_round_teams

  def set_team_at(inx, value)
    @teams[inx] = value.to_s
  end

  def set_winner_at(inx, value)
    @winners[inx] = value.to_i
  end

  def reset
    @teams = Array.new(@num_of_first_round_teams, '___')
    @winners = Array.new(@num_of_matchups)
    puts @winners
  end
end
