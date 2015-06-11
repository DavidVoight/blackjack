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
