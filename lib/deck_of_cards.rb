require 'solitaire_cipher'

class DeckOfCards
  JOKER_A = "a"
  JOKER_B = "b"

  attr_reader :deck

  def initialize(deck)
    @deck = deck
  end

  def obtain_keystream(size)
    keystream = ''
    while keystream.size < size do
      move_joker_A_down
      move_joker_B_down
      @deck = triple_cut_around_jokers
      @deck = perform_count_cut
      keystream << obtain_letter
    end
    keystream
  end

  def move_joker_A_down
    move_card_down(JOKER_A, 1)
  end

  def move_joker_B_down
    move_card_down(JOKER_B, 2)
  end

  def triple_cut_around_jokers
    l, r = [deck.index(JOKER_A), deck.index(JOKER_B)].sort

    left   = l > 0 ? deck[0..l - 1] : []
    middle = deck[l..r]
    right  = deck[(r + 1)..(deck.size - 1)]

    right.concat(middle).concat(left)
  end

  def perform_count_cut
    count = deck.last

    return deck if card_is_joker?(count)

    cut = deck[0..count-1]
    remainder = deck[count..deck.size-2]

    remainder.concat(cut).concat([count])
  end

  def obtain_letter
    position = deck[0]
    position = 53 if card_is_joker?(position)
    card = deck[position]
    return '' if card_is_joker?(card)
    SolitaireCipher.new(nil).numbers_to_letters([card])
  end

  private

  def card_is_joker?(card)
    [JOKER_A, JOKER_B].include?(card)
  end

  def move_card_down(card, count)
    current_position = deck.index(card)
    new_position = current_position + count

    if new_position >= deck.size
      new_position -= deck.size - 1
    end

    deck.delete_at(current_position)
    deck.insert(new_position, card)
  end
end