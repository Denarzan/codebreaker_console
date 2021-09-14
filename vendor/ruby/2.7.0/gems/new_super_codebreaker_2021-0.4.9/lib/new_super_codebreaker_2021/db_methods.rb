module NewSuperCodebreaker2021
  module DBMethods
    def save(user, file)
      rating = load_file(file)
      rating.push(user)
      File.open(file, 'w') do |filename|
        YAML.dump(rating, filename)
      end
    end

    def load_file(file)
      YAML.load_file(file)
    rescue Errno::ENOENT
      []
    end
  end
end
