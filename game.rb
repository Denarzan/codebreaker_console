require_relative 'view'

module Game
  class Game
    attr_reader :user, :game, :used_hints

    def initialize(user, game)
      @user = user
      @game = game
      @used_hints = []
    end

    def user_guess_init
      loop do
        user_input = @game.user_guess(View.get_input(View.write_code))
        return 'lose' if @user.attempts_total == @user.attempts_used + 1

        result = decryption(user_input)
        return 'win' if result == 'win'
      end
    end

    private

    def decryption(user_input)
      case user_input
      when :exit then View.exit_game
      when :hint then hint_command
      when :rules then View.rules
      when false
        puts View.code_error
      else use_attempt(user_input)
      end
    end

    def hint_command
      if @user.hints_total > @user.hints_used
        use_hint
      else
        puts View.zero_hints
      end
    end

    def use_hint
      hint = @game.take_hint(@user, @used_hints)
      @used_hints.push(hint)
      puts hint
    end

    def use_attempt(user_code)
      @user.attempts_used += 1
      compare = @game.compare_codes(user_code)
      print "#{compare.join(' ')}\n"
      'win' if %w[+ + + +].join == compare.join
    end
  end
end
