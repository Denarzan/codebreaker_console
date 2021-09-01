require_relative 'view'
require 'new_super_codebreaker_2021'
module UserCreation
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
      loop do
        name = @game.take_name(View.get_input(View.write_name))
        case name
        when :exit then View.exit_game
        when false then View.bad_name_error
        else
          return name
        end
      end
    end

    def difficulty_init
      difficulty = @game.chose_difficulty(View.get_input(View.difficulties))
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
