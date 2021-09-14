require_relative '../spec_helper'

RSpec.describe CodebreakerConsole::Game do
  subject(:view) { CodebreakerConsole::View }
  let(:user1) do
    instance_double('User', name: 'Name',
                            difficulty: 0, attempts_used: 0, hints_used: 0, attempts_total: 15, hints_total: 2)
  end
  let(:game_double) { instance_double('NewSuperCodebreaker2021::Game') }
  let(:game) { described_class.new(user1, game_double) }
  let(:my_user_creation) { instance_double('CodebreakerConsole::UserCreation') }

  before do
    allow(view).to receive(:puts)
    allow(game).to receive(:puts)
  end

  context '#user_guess_init' do
    before do
      allow(view).to receive(:fetch_input).and_return('1234')
      allow(game_double).to receive(:user_guess).and_return('1234')
      allow(user1).to receive(:attempts_total).and_return(2)
      allow(user1).to receive(:attempts_used).and_return(1)
    end
    it 'should return lose' do
      expect(game.user_guess_init).to eq 'lose'
    end
  end

  context '#user_guess_init' do
    before do
      allow(view).to receive(:fetch_input)
      allow(game_double).to receive(:user_guess)
      expect(game).to receive(:decryption).and_return('win')
    end
    it 'should return win' do
      expect(game.user_guess_init).to eq 'win'
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('1234')
      allow(game_double).to receive(:user_guess).and_return('1234')
      allow(game_double).to receive(:compare_codes).and_return(%w[+ + + +])
      allow(user1).to receive(:attempts_used=)
    end
    it 'should use decryption and return win' do
      expect(game.user_guess_init).to eq 'win'
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('1234', 'exit')
      allow(game_double).to receive(:user_guess).and_return('1234', :exit)
      allow(game_double).to receive(:compare_codes).and_return([])
      allow(user1).to receive(:attempts_used=)
    end
    it 'should use decryption and return win' do
      expect(game.user_guess_init).to receive(:exit).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('exit')
      allow(game_double).to receive(:user_guess).and_return(:exit)
    end
    it 'should use decryption and exit game' do
      expect(view).to receive(:exit_game).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('hint')
      allow(game_double).to receive(:user_guess).and_return(:hint)
    end
    it 'should use decryption and run hint method' do
      expect(game).to receive(:hint_command).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('rules')
      allow(game_double).to receive(:user_guess).and_return(:rules)
    end
    it 'should use decryption and show rules' do
      expect(view).to receive(:rules).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('monkey')
      allow(game_double).to receive(:user_guess).and_return(false)
    end
    it 'should use decryption and show error' do
      expect(view).to receive(:code_error).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('hint')
      allow(game_double).to receive(:user_guess).and_return(:hint)
    end
    it 'should use decryption and run hint method' do
      expect(game).to receive(:use_hint).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('hint')
      allow(game_double).to receive(:user_guess).and_return(:hint)
      allow(user1).to receive(:hints_total).and_return(1)
      allow(user1).to receive(:hints_used).and_return(1)
    end
    it 'should use decryption and show zero hints error' do
      expect(view).to receive(:zero_hints).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end

  context '#decryption' do
    before do
      allow(view).to receive(:fetch_input).and_return('hint')
      allow(game_double).to receive(:user_guess).and_return(:hint)
      allow(game_double).to receive(:take_hint).and_return('1')
    end
    it 'should use decryption and run hint method' do
      expect(game).to receive(:puts).and_raise(SystemExit)
      game.user_guess_init
    rescue SystemExit
      # Ignored
    end
  end
end