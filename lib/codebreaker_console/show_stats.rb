module CodebreakerConsole
  class ShowStats
    DIFFICULTY = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def show_statistic(game, file)
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
  end
end
