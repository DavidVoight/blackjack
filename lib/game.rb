class Game
  attr_reader :deck

  def initialize
    @deck = Hand.new
  end

  def start
    deck.initial_deal
    puts "Player was dealt a #{deck.player_hand[0].rank} of #{deck.player_hand[0].suit} and #{deck.player_hand[1].rank} of #{deck.player_hand[1].suit}"
  end

  def player_result
    if deck.count("player_hand") > 21      #game.count is not needed because the method count is within the class
      puts "YOU ARE BUSTED"
    elsif deck.count("player_hand") == 21
      puts "BLACKJACK!!"
      abort
    else
      print "Would you like to draw another card (Y/N)? "
    end
  end
end
