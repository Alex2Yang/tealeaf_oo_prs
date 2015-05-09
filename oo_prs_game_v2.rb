# nouns: hand(p,r,s),  player, computer, game
# behavior: hand(from user or random choose), player_choice, computer_choice, game_play

class Hand
  include Comparable

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    case value
    when 'p'  then 'Paper'
    when 'r'  then 'Rock'
    when 's'  then 'Scissors'
    end
  end

  def paper?
    value == 'p'
  end

  def scissors?
    value == 's'
  end

  def rock?
    value == 'r'
  end

  def <=>(other_hand)
    if value == other_hand.value
      0
    elsif ( paper? && other_hand.rock? ) ||
          ( scissors? && other_hand.paper? ) ||
          ( rock? && other_hand.scissors? )
      1
    else
      -1
    end
  end
end

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
  end

  def display_hand
    puts "#{name} picked #{hand}."
  end
end

class Human < Player
  def choose
    begin
      puts "Choose one: (P/R/S)"
      answer = gets.chomp.downcase
    end until Game::CHOICES.include?(answer)

    self.hand = Hand.new(answer)
  end
end

class Computer < Player
  def choose
    self.hand = Hand.new(Game::CHOICES.sample)
  end
end

class Game
  CHOICES = ['p', 'r', 's']

  attr_reader :player, :computer

  def initialize
    @player = Human.new(get_user_name)
    @computer = Computer.new('Computer')
  end

  def get_user_name
    puts "What's your name?"
    answer = gets.chomp.downcase.capitalize
  end

  def display_both_hands
    if player.hand == computer.hand
      puts "Both chosen #{player.hand}!"
    else
      player.display_hand
      computer.display_hand
    end
  end

  def compare_hands(player, computer)
    if player.hand > computer.hand
      display_both_hands
      display_winning_message(player)
      puts "#{player.name} won!"
    elsif  player.hand == computer.hand
      display_both_hands
      puts "It's a tie!"
    else
      display_both_hands
      display_winning_message(computer)
      puts "#{computer.name} won!"
    end
  end

  def display_winning_message(winner)
    case winner.hand.value
    when 'p' then puts "Paper wraps Rock!"
    when 'r' then puts "Rock smashes Scissors!"
    when 's' then puts "Scissors cuts Paper!"
    end
  end

  def greet_player
    system "clear"
    puts "Play Paper Rock Sicssors!"
  end

  def game_loop
    loop do
      player.choose
      computer.choose
      compare_hands(player, computer)
      break unless play_again?
    end
  end

  def exit_message
    puts "Goodbye!"
  end

  def run
    greet_player
    game_loop
    exit_message
  end

  def play_again?
    begin
      puts "#{player.name},play again(y/n)?"
      answer = gets.chomp
    end until ['y', 'n'].include?(answer)

    answer == 'y'
  end
end

Game.new.run
