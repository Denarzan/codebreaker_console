require_relative 'spec_helper'
require 'yaml'

RSpec.shared_examples 'puts method' do |name_function, *args|
  describe "##{name_function}" do
    it 'method to output text' do
      expect(subject).to receive(:puts)
      subject.public_send(name_function, *args)
    end
  end
end

RSpec.describe View do
  let(:game_double) { instance_double('NewSuperCodebreaker2021::Game') }
  let(:users) { YAML.load_file('spec/test.yml') }

  before do
    allow(NewSuperCodebreaker2021::Game).to receive(:new) { game_double }
    allow(View).to receive(:puts)
  end

  %i[bad_name_error run start start_new_game error_message rules difficulties write_name
     write_code code_error zero_hints ask_new_game empty_file no_file].each do |function_name|
    include_examples 'puts method', function_name
  rescue SystemExit
    # Ignored
  end

  include_examples 'puts method', :win, [1, 2, 3, 4]
  include_examples 'puts method', :lose, [1, 2, 3, 4]
  describe '#get_input' do
    before do
      allow(View).to receive_message_chain(:gets, :chomp).and_return('text')
    end
    it 'should return text if it is' do
      expect(View.get_input('text')).to eq('text')
    end
  end

  describe '#statistic' do
    before do
      allow(game_double).to receive(:show_stats).and_return(users)
    end
    it 'should return text if it is' do
      expect(View).to receive(:puts)
      View.statistic(game_double, 'test.yml')
    end
  end
end
