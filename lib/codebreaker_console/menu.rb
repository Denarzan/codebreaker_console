module CodebreakerConsole
  class Menu
    include CodebreakerConsole

    FILE = 'rating.yml'.freeze

    def initialize(state = :start_command)
      @file = FILE
      @game = NewSuperCodebreaker2021::Game.new
      @state = state
    end

    def run
      View.run
      loop do
        @state == :shutdown ? break : send(@state)
      end
    end

    private

    def start_command
      View.start
      case @game.chose_command(View.fetch_input)
      when :start then start_game
      when :rules then View.rules
      when :stats then show_statistic
      when :exit then exit_game
      else View.error_message
      end
    end

    def show_statistic
      if File.file?(@file)
        return View.empty_file if File.zero?(@file)

        View.statistic(@game, @file)
      else View.no_file
      end
    end

    def start_game
      @user = UserCreation.new(@game).create_user
      return exit_game if @user == :shutdown

      game
    end

    def game
      game_result = CodebreakerConsole::Game.new(@user, @game).user_guess_init
      case game_result
      when 'win' then win_game
      when 'lose'
        View.lose(@game.code)
        attempt_to_start
      when :shutdown then exit_game
      else View.error_message
      end
    end

    def win_game
      View.win(@game.code)
      command = View.fetch_input
      case command
      when 'save' then save_game
      when 'exit' then exit_game
      when 'start' then View.run
      else
        View.error_message
        win_game
      end
    end

    def save_game
      @game.save(@user, FILE)
      attempt_to_start
    end

    def attempt_to_start
      puts View.start_new_game
      command = @game.attempt_to_start(View.fetch_input)
      case command
      when :yes then true
      when :no then exit_game
      else View.error_message
      end
    end

    def exit_game
      View.exit_game
      @state = :shutdown
    end
  end
end
