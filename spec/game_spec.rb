require 'game'

describe Game do
  subject { Game.new }

  describe '#initialize' do
  end

  describe '#game_over?' do
    context 'when maximum tries are reached' do
      it 'returns true' do
      end
    end

    context 'when code is broken' do
    end

    context 'when code isnt broken and there are tries left' do
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
    context 'when correct input given' do
      it 'assigns correctly' do
        max_tries = 8
        subject.max_tries = max_tries

        expect(subject.max_tries).to eq(max_tries)
      end
    end
  end

  describe '#code_length' do
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

    context 'when input is 4' do
      it 'returns 4' do
        code_length = 4
        subject.code_length = code_length

        expect(subject.code_length).to eq(code_length)
      end
    end

    context 'when input is 6' do
      it 'returns 6' do
        code_length = 6
        subject.code_length = code_length

        expect(subject.code_length).to eq(code_length)
      end
    end

    context 'when input is 8' do
      it 'returns 8' do
        code_length = 8
        subject.code_length = code_length

        expect(subject.code_length).to eq(code_length)
      end
    end
  end

  describe '#set_code' do
  end

  describe '#reset' do
  end

  describe '#evaluate_guess' do
    context 'when input has wrong length' do
      it 'raises ArgumentError' do
        subject.code_length = 6
        expect { subject.evaluate_guess('rgrg') }.to raise_error(ArgumentError, "Guess should be #{code_length} characters long")
      end

      it 'raises ArgumentError' do
      end
    end

    context 'when input is alphanumeric' do
      it 'raises ArgumentError' do
      end
    end

    context 'when input a number' do
      it 'raises ArgumentError' do
      end
    end

    context 'when input has invalid colors' do
      it 'raises ArgumentError' do
      end
    end

    context 'when input has lowercase characters' do
      it 'raises ArgumentError' do
      end
    end

    context 'when input is correct' do
      it 'increments attempt_count' do
      end
    end
  end

  describe '#get_last_state' do
  end

  describe '#code_broken?' do
  end
end
