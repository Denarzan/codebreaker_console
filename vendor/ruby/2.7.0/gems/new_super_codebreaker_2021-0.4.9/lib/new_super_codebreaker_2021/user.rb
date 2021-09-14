module NewSuperCodebreaker2021
  class User
    attr_reader :name, :difficulty, :hints_total, :attempts_total
    attr_accessor :hints_used, :attempts_used

    DIFFICULTY = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize(name, difficulty)
      @name = name
      @difficulty = difficulty
      @hints_used = 0
      @attempts_used = 0
      set_total_fields
    end

    private

    def set_total_fields
      difficulty = DIFFICULTY.keys[@difficulty]
      @hints_total = DIFFICULTY[difficulty][:hints]
      @attempts_total = DIFFICULTY[difficulty][:attempts]
    end
  end
end
