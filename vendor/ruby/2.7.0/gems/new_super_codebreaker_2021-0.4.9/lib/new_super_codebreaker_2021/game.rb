module NewSuperCodebreaker2021
  class Game
    include DBMethods
    include ShowContent
    include Validate

    attr_reader :code

    def initialize
      @code = generate_code
      @code_copy = @code.dup
    end

    GUESS_COMMANDS = %i[hint rules exit].freeze
    START_COMMANDS = %i[start rules stats exit].freeze
    DIFFICULTY_COMMANDS = %i[easy medium hell exit].freeze
    AFTER_GAME_COMMANDS = %i[start save exit].freeze
    YES_NO_COMMANDS = %i[yes no].freeze

    def chose_command(command)
      check_input(command, START_COMMANDS)
    end

    def take_name(input_name)
      if input_name == 'exit'
        :exit
      else
        validate_name(input_name)
      end
    end

    def chose_difficulty(difficulty)
      check_input(difficulty, DIFFICULTY_COMMANDS)
    end

    def user_guess(code)
      return validate_user_code(code) unless code.to_i.zero?

      symbol_code = code.to_sym
      GUESS_COMMANDS.include?(symbol_code) ? symbol_code : nil
    end

    def take_hint(user, used_hints)
      return unless user.hints_total > user.hints_used

      user.hints_used += 1
      used_hints.each { |hint| @code_copy.delete(hint) }
      @code_copy.sample
    end

    def after_game_commands(command)
      check_input(command, AFTER_GAME_COMMANDS)
    end

    def attempt_to_start(command)
      check_input(command, YES_NO_COMMANDS)
    end

    def compare_codes(user_code)
      matches, user_code, code_copy = number_on_right_place(user_code)
      number_in_secret_code(user_code, matches, code_copy)
    end

    private

    def number_on_right_place(user_code)
      code_copy = @code.dup
      matches = []
      user_code.each_index do |i|
        next unless @code[i] == user_code[i]

        matches.unshift('+')
        user_code[i] = nil
        code_copy[i] = false
      end
      [matches, user_code, code_copy]
    end

    def number_in_secret_code(user_code, matches, code_copy)
      amount_numbers_in_secret_code = Hash.new(0)
      amount_numbers_in_user_code = Hash.new(0)
      code_copy.each { |number| amount_numbers_in_secret_code[number] += 1 }
      user_code.each do |element|
        if code_copy.include?(element) && amount_numbers_in_user_code[element] < amount_numbers_in_secret_code[element]
          matches.push('-')
          amount_numbers_in_user_code[element] += 1
        end
      end
      matches
    end

    def generate_code
      Array.new(4) { rand(1..6) }
    end
  end
end
