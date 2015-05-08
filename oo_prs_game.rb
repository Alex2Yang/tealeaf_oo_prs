# nouns: hand(p,r,s),  player, computer, game
# behavior: hand(from user or random choose), player_choice, computer_choice, game_play

class Hand
  attr_accessor :name

  def to_s
    case self.name
    when 'p'  then 'Paper'
    when 'r'  then 'Rock'
    when 's'  then 'Scissors'
    end
  end

end

class Player
  attr_accessor :name, :choice

  def initialize
    self.choice = Hand.new
  end

  def choose
    puts "Choose one: (P/R/S)"
    answer = gets.chomp.downcase
    self.choice.name = answer
  end

end

class Computer
  attr_accessor :name, :choice

  def initialize
    self.name = 'computer'
    self.choice = Hand.new
  end

  def choose
    self.choice.name = ['p', 'r', 's'].sample
  end

end

class Game
  attr_accessor :player, :computer

  def initialize
    self.player = Player.new
    self.computer = Computer.new
  end

  def get_user_name
    puts "What's your name?"
    player.name = gets.chomp
  end

  def compare(player, computer)
    player_choice = player.choice.name
    computer_choice = computer.choice.name

    if (player_choice == 'p' && computer_choice == 'r') ||
       (player_choice == 'r' && computer_choice == 's') ||
       (player_choice == 's' && computer_choice == 'p')
      puts "You picked #{player.choice} and computer picked #{computer.choice}."
      display_winning_message(player)
      puts "You won!"
    elsif player_choice == computer_choice
      puts "It's a tie!"
    else
      puts "You picked #{player.choice} and computer picked #{computer.choice}."
      display_winning_message(computer)
      puts "Computer won!"
    end

  end

  def display_winning_message(winner)
    case winner.choice.name
    when 'p' then puts "Paper wraps Rock!"
    when 'r' then puts "Rock smashes Scissors!"
    when 's' then puts "Scissors cuts Paper!"
    end
  end

  def run
    system "clear"
    puts "Play Paper Rock Sicssors!"
    get_user_name

    loop do
      player.choose
      computer.choose
      compare(player, computer)
      break unless play_again?
    end

    puts "Goodbye!"
  end

  def play_again?
    puts "#{player.name},play again(y/n)?"
    gets.chomp != 'n'
  end

end

Game.new.run
