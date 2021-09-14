module NewSuperCodebreaker2021
  module ShowContent
    def show_stats(file)
      data = YAML.load_file(file) || []
      data.sort_by! { |game| [-game.difficulty, game.attempts_used, game.hints_used] }
    rescue Errno::ENOENT
      []
    end
  end
end
