RSpec.describe CodebreakerConsole::Menu do
  subject(:view) { CodebreakerConsole::View }
  let(:user1) do
    instance_double('User', name: 'Name',
                            difficulty: 0, attempts_used: 0, hints_used: 0, attempts_total: 15, hints_total: 2)
  end
  let(:game_double) { instance_double('NewSuperCodebreaker2021::Game') }
  let(:menu) { described_class.new }
  let(:my_user_creation) { instance_double('CodebreakerConsole::UserCreation') }
  let(:game_module) { instance_double('CodebreakerConsole::Game', user: user1, game: game_double) }
  let(:code) { [1, 2, 3, 4] }

  before do
    allow(NewSuperCodebreaker2021::Game).to receive(:new) { game_double }
    allow(game_double).to receive(:code).and_return(code)
    stub_const('CodebreakerConsole::Menu::FILE', 'test.yml')
    allow(menu).to receive(:puts)
    allow(view).to receive(:puts)
  end

  describe '#run' do
    after do
      menu.run
    end

    context '#start_command' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('rules', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:rules, :exit)
      end
      it 'output rules if input is rules' do
        expect(view).to receive(:rules)
      end
    end

    context '#start_command' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('stats', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:stats, :exit)
      end
      it 'output stats if input is stats' do
        expect(view).to receive(:no_file)
      end
    end

    context '#start_command' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(game_double).to receive(:take_name).and_return(:exit)
        allow(CodebreakerConsole::Game).to receive_message_chain(:new, :user_guess_init).and_return(:shutdown)
      end
      it 'starts game if input is start' do
        expect(CodebreakerConsole::UserCreation).to receive_message_chain(:new, :create_user)
      end
    end

    context '#start_command' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('monkey', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:monkey, :exit)
      end
      it 'output error if input is monkey' do
        expect(view).to receive(:error_message)
      end
    end

    context '#show_statistic' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('stats', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:stats, :exit)
      end
      it 'should return file does not exist' do
        expect(view).to receive(:no_file)
      end
    end

    context '#show_statistic' do
      before do
        File.open('test.yml', 'w')
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('stats', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:stats, :exit)
      end
      after do
        File.delete('test.yml') if File.exist? 'test.yml'
      end

      it 'should return empty file' do
        expect(view).to receive(:empty_file)
        menu.run
      end
    end

    context '#show_statistic' do
      before do
        File.open('test.yml', 'w') { |file| file.write('stat') }
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('stats', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:stats, :exit)
      end
      after do
        File.delete('test.yml') if File.exist? 'test.yml'
      end

      it 'should return statistic' do
        expect(view).to receive(:statistic)
        menu.run
      end
    end

    context '#start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(game_double).to receive(:take_name).and_return(:exit)
        allow(CodebreakerConsole::Game).to receive_message_chain(:new, :user_guess_init).and_return(:shutdown)
      end
      it 'call game method' do
        expect(CodebreakerConsole::UserCreation).to receive_message_chain(:new, :create_user)
      end
    end

    context '#game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
      end
      it 'call win_game method' do
        expect(view).to receive(:win)
      end
    end

    context '#game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'exit', 'no')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('lose')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:code)
        allow(game_double).to receive(:attempt_to_start).and_return(:no)
      end
      it 'call lose method' do
        expect(view).to receive(:lose)
      end
    end

    context '#game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('monkey', :shutdown)
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start)
      end
      it 'call error_message method' do
        expect(view).to receive(:error_message)
      end
    end

    context '#win_game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'save', 'exit')
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start).and_return(:no)
      end
      it 'call save_game method' do
        expect(game_double).to receive(:save)
      end
    end

    context '#win_game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'exit')
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start).and_return(:no)
      end
      it 'call exit method' do
        expect(view).to receive(:exit_game)
      end
    end

    context '#win_game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'start', 'exit')
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
      end
      it 'call start method' do
        expect(view).to receive(:run).twice
      end
    end

    context '#win_game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'monkey', 'exit', 'exit')
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
      end
      it 'call error method' do
        expect(view).to receive(:error_message)
      end
    end

    context '#save_game' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'save', 'exit')
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:save)
        allow(game_double).to receive(:attempt_to_start).and_return(:no)
      end
      it 'call save method and ask for after new game' do
        expect(view).to receive(:start_new_game)
      end
    end

    context '#attempt_to_start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'save', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:save)
        allow(game_double).to receive(:attempt_to_start).and_return(:yes)
      end
      it 'ask for a new game after win after write yes' do
        expect(:attempt_to_start).to be_truthy
      end
    end

    context '#attempt_to_start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'save', 'exit')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('win')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:save)
        allow(game_double).to receive(:attempt_to_start).and_return(:no)
      end
      it 'ask for a new game after win after write no' do
        expect(view).to receive(:exit_game)
      end
    end

    context '#attempt_to_start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('lose')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start).and_return(:yes, :no)
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
      end
      it 'ask for a new game after lose after write yes' do
        expect(:attempt_to_start).to be_truthy
      end
    end

    context '#attempt_to_start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'yes')
        allow(game_double).to receive(:chose_command).and_return(:start, :exit)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return(:shutdown)
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start).and_return(:yes, :no)
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
      end
      it 'ask for a new game after lose after write yes' do
        expect(:attempt_to_start).to be_truthy
      end
    end

    context '#attempt_to_start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'no')
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('lose')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start).and_return(:no)
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
      end
      it 'ask for a new game after lose after write no' do
        expect(view).to receive(:exit_game)
      end
    end

    context '#attempt_to_start' do
      before do
        allow($stdin).to receive_message_chain(:gets, :chomp).and_return('start', 'no')
        allow(game_double).to receive(:chose_command).and_return(:start)
        allow(my_user_creation).to receive(:create_user).and_return(user1)
        allow(CodebreakerConsole::UserCreation).to receive(:new).and_return(my_user_creation)
        allow(game_module).to receive(:user_guess_init).and_return('lose')
        allow(CodebreakerConsole::Game).to receive(:new).and_return(game_module)
        allow(game_double).to receive(:attempt_to_start).and_return(:monkey, :no)
        allow(game_double).to receive(:code).and_return([1, 2, 3, 4])
      end
      it 'show error message if bad input' do
        expect(view).to receive(:error_message)
      end
    end
  end
end
