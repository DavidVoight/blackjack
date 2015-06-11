#!/usr/bin/env ruby
require "pry"

class Card
attr_reader :rank, :suit
  def initialize(rank, suit)
  @rank = rank
  @suit = suit
  end

  def value
    return 10 if ['J', 'Q', 'K'].include?(@rank)
    return 11 if ['A'].include?(@rank)
    return @rank
  end

end

SUITS = ['♠', '♣', '♥', '♦']
VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

class Deck
  def initialize
    @collection = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @collection << Card.new(value, suit)
      end
    end

    @collection.shuffle!
  end

  def draw!
    @collection.pop
  end
end


class Hand
  attr_accessor :player_hand, :dealer_hand
  attr_reader :deck

  def initialize
    @player_hand = []
    @dealer_hand = []
    @deck = Deck.new
  end

  def initial_deal
    2.times do
      player_hand << deck.draw!
      dealer_hand << deck.draw!
    end
  end

  def player_deal
    player_hand << deck.draw!
  end

  def dealer_deal
    dealer_hand << deck.draw!
  end

  def count(hand)
    if hand == "player_hand"
      hand = player_hand
    else
      hand = dealer_hand
    end

    total_hand = 0
    hand.each do |card|
      total_hand += card.value
    end

    ace_count = 0

    hand.each do |card|
      if card.rank == "A"
        ace_count += 1
      end
    end

    if total_hand > 21
      while ace_count > 0
      total_hand -= 10
      ace_count -= 1
      end
    end

    total_hand
  end
end


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
