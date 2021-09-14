module CodebreakerConsole
  class UserCreation
    include View

    def initialize(game)
      @game = game
    end

    def create_user
      name = name_init
      difficulty = difficulty_init
      case difficulty
      when 'easy' then User.new(name, 0)
      when 'medium' then User.new(name, 1)
      when 'hell' then User.new(name, 2)
      else View.error_message
      end
    end

    private

    def name_init
      View.write_name
      name = @game.take_name(View.fetch_input)
      case name
      when :exit then View.exit_game
      when false then View.bad_name_error
      else
        return name
      end
      name_init
    end

    def difficulty_init
      View.difficulties
      difficulty = @game.chose_difficulty(View.fetch_input)
      check_difficulty(difficulty)
    end

    def check_difficulty(difficulty)
      case difficulty
      when :easy then 'easy'
      when :medium then 'medium'
      when :hell then 'hell'
      when :exit then View.exit_game
      else
        View.error_message
        difficulty_init
      end
    end
  end
end
