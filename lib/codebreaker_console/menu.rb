# frozen_string_literal: true

module CodebreakerConsole
  class Menu
    include CodebreakerConsole

    def initialize
      @file = 'rating.yml'
    end

    def run
      @game = NewSuperCodebreaker2021::Game.new
      View.run
      start_command
    end

    private

    def start_command
      View.start
      case @game.chose_command(View.fetch_input)
      when :start then start_game
      when :rules then View.rules
      when :stats then show_statistic
      when :exit then View.exit_game
      else
        View.error_message
        start_command
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
      game_result = CodebreakerConsole::Game.new(@user, @game).user_guess_init
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
      View.win(@game.instance_variable_get(:@code))
      command = View.fetch_input
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
      puts View.start_new_game
      command = @game.attempt_to_start(View.fetch_input)
      case command
      when :yes then true
      when :no then View.exit_game
      else
        View.error_message
      end
    end
  end
end
