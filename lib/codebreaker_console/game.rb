module CodebreakerConsole
  class Game
    attr_reader :user, :game, :used_hints

    WIN = '++++'.freeze

    def initialize(user, game)
      @user = user
      @game = game
      @used_hints = []
    end

    def user_guess_init
      View.write_code
      user_input = @game.user_guess(View.fetch_input)
      return 'lose' if @user.attempts_total == @user.attempts_used + 1

      result = decryption(user_input)
      return 'win' if result == 'win'
      return 'shutdown' if result == :shutdown

      user_guess_init
    end

    private

    def decryption(user_input)
      case user_input
      when :exit then :shutdown
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
      'win' if compare.join == WIN
    end
  end
end
