RSpec.describe CodebreakerConsole::ShowStats do
  let(:game_double) { instance_double('NewSuperCodebreaker2021::Game') }
  let(:current_class) { described_class.new }
  let(:file) { 'spec/support/test_users.yml' }
  let(:users) { YAML.load_file(file) || [] }

  describe '#show_statistic' do
    it 'should return text if it is' do
      allow(game_double).to receive(:show_stats).and_return(users)
      expect(current_class).to receive(:puts)
      current_class.show_statistic(game_double, file)
    end
  end
end
