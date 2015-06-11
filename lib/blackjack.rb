require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'game'

SUITS = ['♠', '♣', '♥', '♦']
VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

puts "Welcome to BlackJack! \n\n"
game = Game.new
game.start
game.deck.count("player_hand")
game.player_result
answer = gets.chomp.upcase
i = 2
while answer == 'Y'
  game.deck.player_deal
  puts "\nPlayer has received additional card #{game.deck.player_hand[i].rank} of #{game.deck.player_hand[i].suit}\n\n"  #game.deck.player_hand is needed because the deck and player_hand is coming from different class
  game.deck.count("player_hand")
  game.player_result
  i += 1
  break if game.deck.count("player_hand") >= 21
  answer = gets.chomp.upcase
end

if answer == 'N'
  if game.deck.count("player_hand") < 21
    until game.deck.count("dealer_hand") >= 17
      game.deck.dealer_deal
    end
    if game.deck.count("dealer_hand") > 21
      puts "\nDEALER HAS BUSTED, PLAYER WINS! :)"
    else
      puts ""
      game.deck.dealer_hand.each do |card|
        puts "Dealer was dealt #{card.rank} of #{card.suit}."
      end

      if game.deck.count("player_hand") > game.deck.count("dealer_hand")
        puts "PLAYER WINS! :)"
        puts ""
        puts "Dealer score is: #{game.deck.count("dealer_hand")}"
        puts "Player score is: #{game.deck.count("player_hand")}"
      elsif game.deck.count("player_hand") == game.deck.count("dealer_hand")
        puts "GAME ENDS IN A TIE"
        puts ""
        puts "Dealer score is: #{game.deck.count("dealer_hand")}"
        puts "Player score is: #{game.deck.count("player_hand")}"
      else
        puts "DEALER WINS :("
        puts ""
        puts "Dealer score is: #{game.deck.count("dealer_hand")}"
        puts "Player score is: #{game.deck.count("player_hand")}"
      end
    end
  end
end
