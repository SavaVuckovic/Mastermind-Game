require 'game'

describe Game do
  subject { Game.new }

  describe '#initialize' do
    it 'initializes attempts' do 
      expect(subject.attempts).to eq(0)
    end

    it 'initializes max_tries' do 
      expect(subject.max_tries).to eq(Game::DEFAULT_MAX_TRIES)
    end

    it 'initializes code_length' do 
      expect(subject.code_length).to eq(Game::DEFAULT_CODE_LENGTH)
    end
  end

  describe '#reset' do
    it 'generates new code' do
      old_code = subject.code

      subject.reset

      expect(subject.code).not_to eql(old_code) 
    end

    it 'resets attempts' do
      old_attempts = subject.attempts   
      
      subject.evaluate_guess('RGBYWP')
      subject.evaluate_guess('GRRRRR')

      subject.reset

      expect(subject.attempts).to eq(0)
     end

     it 'resets max_tries' do
      old_max_tries = subject.max_tries   
      
      subject.max_tries = 10
      subject.reset

      expect(subject.max_tries).to eq(Game::DEFAULT_MAX_TRIES)
     end

     it 'resets code_length' do
      old_code_length = subject.code_length   
      
      subject.code_length = 4
      subject.reset

      expect(subject.code_length).to eq(Game::DEFAULT_CODE_LENGTH)
     end
  end

  describe '#game_over?' do
    context 'when maximum tries are reached' do
      it 'returns true' do
        subject.max_tries.times { subject.evaluate_guess('RRRRRR') }
        expect(subject.game_over?).to eq(true)
      end
    end

    context 'when code is broken' do
      it 'returns true' do 
        code = 'RGWBYP'
        allow(subject).to receive(:code).and_return(code)
        subject.evaluate_guess(code)
        expect(subject.game_over?).to eq(true)
      end
    end

    context 'when code isn\'t broken and there are tries left' do
      it 'returns false' do 
        allow(subject).to receive(:code).and_return('RGPWBY')
        
        subject.evaluate_guess('RRRRRR')
        expect(subject.game_over?).to eq(false)

        subject.evaluate_guess('GGGGGG')
        expect(subject.game_over?).to eq(false)
      end
    end
  end

  describe '#max_tries=' do
    context "when argument isn't a number" do
      it 'raises an TypeError' do
        expect { subject.max_tries = 'Not a number' }.to raise_error(TypeError)
      end
    end
    context 'when argument range is invalid' do
      it 'raises an ArgumentError' do
        expect { subject.max_tries = 5 }.to raise_error(ArgumentError)
      end

      it 'raises an ArgumentError' do
        expect { subject.max_tries = 13 }.to raise_error(ArgumentError)
      end
    end
    context 'when valid' do
      it 'assigns correctly' do
        max_tries = 8
        subject.max_tries = max_tries

        expect(subject.max_tries).to eq(max_tries)
      end
    end
  end

  describe '#code_length=' do
    context "when argument isn't a number" do
      it 'raises an TypeError' do
        expect { subject.code_length = 'Not a number' }.to raise_error(TypeError)
      end
    end

    context 'when invalid length' do
      it 'raises an ArgumentError' do
        expect { subject.code_length = 7 }.to raise_error(ArgumentError)
      end

      it 'raises an ArgumentError' do
        expect { subject.code_length = 13 }.to raise_error(ArgumentError)
      end
    end

    context 'when valid' do
      it 'returns code' do
        code_length = 4
        subject.code_length = code_length
        expect(subject.code_length).to eq(code_length)

        code_length = 6
        subject.code_length = code_length
        expect(subject.code_length).to eq(code_length)

        code_length = 8
        subject.code_length = code_length
        expect(subject.code_length).to eq(code_length)
      end
    end
  end

  describe '#evaluate_guess' do
    context 'when guess has wrong length' do
      it 'raises ArgumentError' do
        subject.code_length = 4
        expect { subject.evaluate_guess('rgrgrr') }.to raise_error(ArgumentError, "Guess should be #{subject.code_length} characters long")
      end

      it 'raises ArgumentError' do
        expect { subject.evaluate_guess('rgrg') }.to raise_error(ArgumentError, "Guess should be #{subject.code_length} characters long")
      end

      it 'raises ArgumentError' do
        subject.code_length = 8
        expect { subject.evaluate_guess('rgrg') }.to raise_error(ArgumentError, "Guess should be #{subject.code_length} characters long")
      end
    end

    context 'when guess contains numbers' do
      it 'raises ArgumentError' do
        guess = "a1b2hg45123gh"
        guess.slice!(0, Game::DEFAULT_CODE_LENGTH)

        expect { subject.evaluate_guess(guess) }.to raise_error(ArgumentError, "Guess cannot contain numbers")
      end

      it 'raises ArgumentError' do
        guess = 1234213421341234
        guess.to_s.slice!(0, Game::DEFAULT_CODE_LENGTH).to_i

        expect { subject.evaluate_guess(guess) }.to raise_error(ArgumentError, "Guess cannot contain numbers")
      end
    end

    context 'when guess has invalid colors' do
      
      it 'raises ArgumentError' do
        guess = "qwgmklvxzdja"
        guess.slice!(0, Game::DEFAULT_CODE_LENGTH)

        expect { subject.evaluate_guess(guess) }.to raise_error(ArgumentError, "Guess cannot contain invalid colors")
      end
    end

    context 'when guess is correct' do
      it 'increments attempt_count' do
        current_attempt_count = subject.attempts
        subject.evaluate_guess('RGBYWP')
        expect(subject.attempts).to eq(current_attempt_count + 1)
      end
    end
  end

  describe '#get_last_state' do
  end
end
