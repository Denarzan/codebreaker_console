module CodebreakerConsole
  class Menu
    attr_reader :state

    include CodebreakerConsole

    FILE = 'rating.yml'.freeze
    ALLOWED_STATES = { start: :start,
                       rules: :view_rules,
                       stats: :show_statistic,
                       exit: :shutdown }.freeze

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
      input_sym = @game.chose_command(View.fetch_input)
      return @state = ALLOWED_STATES[input_sym] if ALLOWED_STATES.include?(input_sym)

      View.error_message
    end

    def show_statistic
      if File.file?(@file)
        if File.zero?(@file)
          @state = :start_command
          return View.empty_file
        end
        View.statistic(@game, @file)
      else View.no_file
      end
      @state = :start_command
    end

    def start
      @user = UserCreation.new(@game).create_user
      return shutdown if @user == :shutdown

      @state = :game
    end

    def view_rules
      View.rules
      @state = :start_command
    end

    def game
      game_result = CodebreakerConsole::Game.new(@user, @game).user_guess_init
      case game_result
      when 'win' then win_game
      when 'lose'
        View.lose(@game.code)
        @state = :attempt_to_start
      when :shutdown then shutdown
      else View.error_message
      end
    end

    def win_game
      View.win(@game.code)
      command = View.fetch_input
      case command
      when 'save' then save_game
      when 'exit' then shutdown
      when 'start' then View.run
      else
        View.error_message
        @state = :win_game
      end
    end

    def save_game
      @game.save(@user, FILE)
      @state = :attempt_to_start
    end

    def attempt_to_start
      View.start_new_game
      command = @game.attempt_to_start(View.fetch_input)
      case command
      when :yes then @state = :start
      when :no then shutdown
      else View.error_message
      end
    end

    def shutdown
      View.exit_game
      @state = :shutdown
    end
  end
end
