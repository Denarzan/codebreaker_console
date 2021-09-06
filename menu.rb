# frozen_string_literal: true

require_relative 'user_creation'
require_relative 'game'

class Menu
  include View
  include UserCreation
  include Game

  def initialize(file)
    @file = file
  end

  def run
    @game = NewSuperCodebreaker2021::Game.new
    View.run
    puts @game.instance_variable_get(:@code).class
    start_command
  end

  private

  def start_command
    loop do
      case @game.chose_command(View.get_input(View.start))
      when :start then start_game
      when :rules then View.rules
      when :stats then show_statistic
      when :exit then View.exit_game
      else View.error_message
      end
    end
  end

  def show_statistic
    if File.zero?(@file)
      View.empty_file
    elsif File.file?(@file)
      View.statistic(@game, @file)
    else
      View.no_file
    end
  end

  def start_game
    @user = UserCreation.new(@game).create_user
    game
  end

  def game
    game_result = Game.new(@user, @game).user_guess_init
    case game_result
    when 'win' then win_game
    when 'lose'
      View.lose(@game.instance_variable_get(:@code))
      attempt_to_start
    else
      View.error_message
    end
  end

  def win_game
    command = View.get_input(View.win(@game.instance_variable_get(:@code)))
    case command
    when 'save' then save_game
    when 'exit' then View.exit_game
    when 'start' then View.run
    else
      View.error_message
      win_game
    end
  end

  def save_game
    @game.save(@user, 'rating.yml')
    attempt_to_start
  end

  def attempt_to_start
    command = @game.attempt_to_start(View.get_input(View.start_new_game))
    case command
    when :yes then true
    when :no then View.exit_game
    else
      View.error_message
    end
  end
end
