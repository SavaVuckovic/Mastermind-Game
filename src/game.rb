require_relative 'board'
require_relative 'player'

class Game

  def initialize
    @action = 0
    @last_action = @action
  end

  public
  # displays home screen, only shown once at the beginning of the game
  def show_home_screen
    Screen.show_game_intro
    start_game_loop
  end

  private
  #starts the game loop
  def start_game_loop
    until @last_action == 3
      get_user_action

      case @action
        when 1 then start_as_guesser
        when 2 then start_as_coder
        when 3 then exit
      end
    end
  end

  # action local variable
  def action=(action)
    # add validation
    if(![1,2,3].include?(action.to_i))
      raise ArgumentError.new("Invalid input : '#{action}'")
    end

    # todo add validation later
    @last_action = @action = action.to_i
  end

  # take the input from the user
  def get_user_action
    Screen.show_home_menu
    response = gets.chomp

    # catch errors
    begin
      self.action = response
    rescue ArgumentError => e
      puts "#{e.message}, please enter a valid option number"
    end
  end

  # start the game mode 1
  def start_as_guesser
    Screen.show_guesser_instructions

    # todo generate random code
    @player = Player.new
    @board = Board.new('RCPWOG')

    # infinite playing loop
    until @board.game_over
      play_round
    end
    @board.display

    # display the results of the game
    if @board.code_broken
      Screen.show_win
    else
      Screen.show_lost
    end
  end

  # play a round
  def play_round
    @board.display

    begin
      guess = @player.make_guess
      @board.update_state(guess)
    rescue ArgumentError => e
      puts "Hey! #{e.message}"
      retry
    end
  end

  # start the game mode 2
  def start_as_coder
    Screen.show_coder_instructions
  end

  # exit the game
  def exit
    print 'Are you sure you want to quit? (y/n): '
    response = gets.chomp
    if ['y', 'yes'].include?(response.downcase)
      Screen.show_goodbye
    else
      @last_action = 0
    end
  end

  class Screen

    # show game intro menu
    def self.show_game_intro
      puts %{
===========================================
   MASTERMIND : By Sava & Kevin
===========================================
Welcome to Mastermind!
You shall not pass on the first try 😈
      }
    end

    # displays menu options
    def self.show_home_menu
      print %{
  1. Break the code
  2. Create the unbreakable code
  3. Take the red pill (Quit)

So, what will it be?
(Enter an option 1,2 or 3): }
    end

    # show instructions
    def self.show_guesser_instructions
      puts %{
These are the available colors:

  #{'R'.red} - red
  #{'G'.green} - green
  #{'B'.blue} - blue
  #{'O'.orange} - orange
  #{'W'.white} - white
  #{'Y'.yellow} - yellow
  #{'P'.pink} - pink
  #{'C'.cyan} - cyan
      }
    end

    def self.show_coder_instructions
      puts %{
Enter your unbreakable code:
Code( e.g. `R G B W C P`):
      }
    end

    # show winning screen
    def self.show_win
      puts 'WON!'
    end

    # show game over screen
    def self.show_lost
      puts 'LOST!'
    end

    # show goodbye message to the user
    def self.show_goodbye
      puts %{
You ran away. We won't judge you, but come back for another challenge later.
      }
    end

  end
end
