require_relative 'view'

module Game
  class Game
    attr_reader :user, :code, :game, :used_hints

    def initialize(user, code, game)
      @user = user
      @code = code
      @game = game
      @used_hints = []
    end

    def user_guess_init
      loop do
        # puts @code
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
      code_copy = @code.dup
      hint = @game.take_hint(@user, code_copy, @used_hints)
      @used_hints.push(hint)
      puts hint
    end

    def use_attempt(user_code)
      @user.attempts_used += 1
      compare = @game.compare_codes(@code, user_code)
      print "#{compare.join(' ')}\n"
      'win' if %w[+ + + +].join == compare.join
    end
  end
end
