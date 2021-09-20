RSpec.describe CodebreakerConsole::UserCreation do
  subject(:view) { CodebreakerConsole::View }
  let(:user1) do
    instance_double('User', name: 'Name',
                            difficulty: 0, attempts_used: 0, hints_used: 0, attempts_total: 15, hints_total: 2)
  end
  let(:game_double) { instance_double('NewSuperCodebreaker2021::Game') }
  let(:my_user_creation) { described_class.new(game_double) }
  let(:game_module) { instance_double('CodebreakerConsole::Game', user: user1, code: [1, 2, 3, 4], game: game_double) }

  before do
    allow(NewSuperCodebreaker2021::Game).to receive(:new) { game_double }
    allow(view).to receive(:puts)
  end

  describe '#create_user' do
    context '#name_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('Nazar', 'exit')
        allow(game_double).to receive(:take_name).and_return('Nazar')
        allow(game_double).to receive(:chose_difficulty).and_return(:exit)
      end
      it 'output name and exit the game' do
        expect(view).to receive(:exit_game)
        my_user_creation.create_user
      end
    end

    context '#name_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('exit')
        allow(game_double).to receive(:take_name).and_return(:exit)
      end
      it 'output name and exit the game' do
        expect(view).to receive(:exit_game).and_raise(SystemExit)
        my_user_creation.create_user
      rescue SystemExit
        # Ignored
      end
    end

    context '#name_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('N')
        allow(game_double).to receive(:take_name).and_return(false)
      end
      it 'output name and call error message' do
        expect(view).to receive(:bad_name_error).and_raise(SystemExit)
        my_user_creation.create_user
      rescue SystemExit
        # Ignored
      end
    end

    context '#name_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('N', 'exit')
        allow(game_double).to receive(:take_name).and_return(false, :exit)
      end
      it 'output name and call error message and then exit' do
        expect(view).to receive(:exit).and_raise(SystemExit)
        my_user_creation.create_user
      rescue SystemExit
        # Ignored
      end
    end

    context '#name_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('Nazar', 'monkey', 'monkey2')
        allow(game_double).to receive(:take_name).and_return('Nazar')
        allow(game_double).to receive(:chose_difficulty).and_return(:monkey, :monkey2)
      end
      it 'output name and call error message' do
        expect(view).to receive(:error_message).and_raise(SystemExit)
        my_user_creation.create_user
      rescue SystemExit
        # Ignored
      end
    end

    context '#difficulty_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('Nazar', 'easy')
        allow(game_double).to receive(:take_name).and_return('Nazar')
        allow(game_double).to receive(:chose_difficulty).and_return(:easy)
      end
      it 'output user with name Nazar and easy difficulty' do
        expect(my_user_creation.create_user.difficulty).to eq(0)
        expect(my_user_creation.create_user.name).to eq('Nazar')
      end
    end

    context '#difficulty_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('Nazar', 'medium')
        allow(game_double).to receive(:take_name).and_return('Nazar')
        allow(game_double).to receive(:chose_difficulty).and_return(:medium)
      end
      it 'output user with name Nazar and medium difficulty' do
        expect(my_user_creation.create_user.difficulty).to eq(1)
        expect(my_user_creation.create_user.name).to eq('Nazar')
      end
    end

    context '#difficulty_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('Nazar', 'hell')
        allow(game_double).to receive(:take_name).and_return('Nazar')
        allow(game_double).to receive(:chose_difficulty).and_return(:hell)
      end
      it 'output user with name Nazar and hell difficulty' do
        expect(my_user_creation.create_user.difficulty).to eq(2)
        expect(my_user_creation.create_user.name).to eq('Nazar')
      end
    end

    context '#difficulty_init' do
      before do
        allow(view).to receive(:fetch_input).and_return('Nazar', 'monkey', 'exit')
        allow(game_double).to receive(:take_name).and_return('Nazar')
        allow(game_double).to receive(:chose_difficulty).and_return(:monkey, :exit)
      end
      it 'output user with name Nazar and hell difficulty' do
        expect(view).to receive(:error_message)
        my_user_creation.create_user
      rescue SystemExit
        # Ignored
      end
    end
  end
end
