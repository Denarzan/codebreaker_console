module CodebreakerConsole
  module View
    class << self
      DIFFICULTY = {
        easy: { attempts: 15, hints: 2 },
        medium: { attempts: 10, hints: 1 },
        hell: { attempts: 5, hints: 1 }
      }.freeze

      def run
        puts I18n.t 'menu.run'
      end

      def start
        puts I18n.t 'menu.start'
      end

      def rules
        puts I18n.t 'menu.rules'
      end

      def exit_game
        puts I18n.t 'menu.exit'
        exit
      end

      def fetch_input
        $stdin.gets.chomp
      end

      def error_message
        puts I18n.t 'error.command'
      end

      def bad_name_error
        puts I18n.t 'error.name'
      end

      def difficulties
        puts I18n.t 'menu.difficulties'
      end

      def write_name
        puts I18n.t 'menu.name'
      end

      def write_code
        puts I18n.t 'menu.code'
      end

      def code_error
        puts I18n.t 'error.code'
      end

      def zero_hints
        puts I18n.t 'game.hints'
      end

      def win(code)
        puts I18n.t('game.win', code: code.join)
      end

      def lose(code)
        puts I18n.t('game.lose', code: code.join)
      end

      def ask_new_game
        puts I18n.t 'game.new'
      end

      def empty_file
        puts I18n.t 'menu.stats.empty'
      end

      def no_file
        puts I18n.t 'menu.stats.nofile'
      end

      def statistic(game, file)
        users = game.show_stats(file)
        rate = 1
        table = Terminal::Table.new(headings: ['Rating', 'Name', 'Difficulty', 'Attempts Total',
                                               'Attempts Used', 'Hints Total', 'Hints Used'])
        users.each do |user|
          table.add_row([rate, user.name, DIFFICULTY.keys[user.difficulty],
                         user.attempts_total, user.attempts_used, user.hints_used, user.hints_total])
          rate += 1
        end
        puts table
      end

      def start_new_game
        puts I18n.t 'game.start'
      end
    end
  end
end
