class Game

  attr_reader :code_length
  attr_reader :max_tries

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
    raise ArgumentError.new("Guess cannot contain numbers") unless guess =~ /^[RGBYWCPO]+$/
    raise ArgumentError.new("Guess should be #{@code_length} characters long") if guess.length != @code_length
  end

end
