module NewSuperCodebreaker2021
  module Validate
    def validate_name(name)
      name if valid_name?(name)
    end

    def validate_user_code(us_code)
      arr_code = split_to_integer_array(us_code)
      return unless valid_number?(arr_code)

      arr_code
    end

    def check_input(input, command_list)
      return unless valid_input?(input, command_list)

      input.to_sym
    end

    private

    def valid_input?(input, command_list)
      input.to_i.zero? && command_list.include?(input.to_sym)
    end

    def valid_number?(arr_code)
      arr_code && check_code_length?(arr_code) && check_numbers?(arr_code)
    end

    def split_to_integer_array(code)
      code.chars.map!(&:to_i) if integer?(code)
    end

    def integer?(code)
      code.to_i.to_s == code
    end

    def check_code_length?(code)
      code.length == 4
    end

    def check_numbers?(code)
      code.all? { |value| value.between?(1, 6) }
    end

    def valid_name?(name)
      name.length >= 3 && name.length <= 20
    end
  end
end
