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
