require 'solitaire_cipher'

class DeckOfCards
  JOKER_A = "a"
  JOKER_B = "b"

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

    return deck if [JOKER_A, JOKER_B].include?(count)

    cut = deck[0..count-1]
    remainder = deck[count..deck.size-2]

    remainder.concat(cut).concat([count])
  end

  def obtain_letter(deck)
    position = deck[deck[0]]
    SolitaireCipher.new.numbers_to_letters([[position]])
  end

  private

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