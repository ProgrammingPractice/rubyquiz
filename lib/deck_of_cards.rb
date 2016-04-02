require 'solitaire_cipher'

class DeckOfCards
  JOKER_A = "a"
  JOKER_B = "b"

  def obtain_keystream(size, deck)
    # move_joker_A_down(deck)
    # move_joker_B_down(deck)
    # triple_cut_around_jokers(deck)
    # perform_count_cut(deck)
    obtain_letter(deck)
  end

  def move_joker_A_down(deck)
    move_card_down(deck, JOKER_A, 1)
  end

  def move_joker_B_down(deck)
    move_card_down(deck, JOKER_B, 2)
  end

  def triple_cut_around_jokers(deck)
    l, r = [deck.index(JOKER_A), deck.index(JOKER_B)].sort

    left   = l > 0 ? deck[0..l - 1] : []
    middle = deck[l..r]
    right  = deck[(r + 1)..(deck.size - 1)]

    right.concat(middle).concat(left)
  end

  def perform_count_cut(deck)
    count = deck.last

    return deck if card_is_joker?(count)

    cut = deck[0..count-1]
    remainder = deck[count..deck.size-2]

    remainder.concat(cut).concat([count])
  end

  def obtain_letter(deck)
    position = deck[0]
    position = 53 if card_is_joker?(position)
    card = deck[position]
    return '' if card_is_joker?(card)
    SolitaireCipher.new.numbers_to_letters([[card]])
  end

  private

  def card_is_joker?(card)
    [JOKER_A, JOKER_B].include?(card)
  end

  def move_card_down(deck, card, positions)
    current = deck.index(card)
    new = current + positions

    if new >= deck.size
      new -= deck.size
    end

    deck.delete_at(current)
    deck.insert(new, card)
  end
end