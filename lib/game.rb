class Game

  DEFAULT_MAX_TRIES = 12
  DEFAULT_CODE_LENGTH = 6

  attr_reader :code_length
  attr_reader :max_tries
  attr_reader :attempts
  attr_reader :code

  def initialize
    @attempts = []
    reset
  end

  def reset
    @attempts.clear
    @max_tries = DEFAULT_MAX_TRIES
    @code_length = DEFAULT_CODE_LENGTH
    generate_code
  end

  def max_tries=(tries)
    raise TypeError unless tries.is_a? Integer
    raise ArgumentError, 'Invalid tries count. Expected input between 6 and 12' unless tries.between?(6, 12)
    @max_tries = tries
  end

  def code_length=(code_length)
    raise TypeError unless code_length.is_a? Integer
    raise ArgumentError, 'Invalid code length. Expected 4, 6 or 8' unless [4, 6, 8].include?(code_length)
    @code_length = code_length
  end

  def evaluate_guess guess
    # validate input
    raise ArgumentError.new("Guess should be #{@code_length} characters long") if guess.to_s.length != @code_length
    raise ArgumentError.new("Guess cannot contain numbers") if guess.to_s =~ /\d/
    raise ArgumentError.new("Guess cannot contain invalid colors") unless guess =~ /^[RGBYWCPO]+$/i

    value = { colors: 0, positions: 0 }

    @attempts << { guess: guess, feedback: value }
    @last_guess = guess
  end

  def game_over?
    @attempts.length == max_tries || @last_guess == code
  end

  # def last_feedback
  #   { colors: 3 }
  # end

  private
  def generate_code
    @code = 'RGBOPWCY'.split('').shuffle.join('').slice(0, @code_length)
  end
end
