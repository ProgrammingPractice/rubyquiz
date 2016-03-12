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
    i = deck.index(JOKER_A)
    j = deck.index(JOKER_B)
    min = [i, j].min
    max = [i, j].max
    i = min
    j = max
    left = deck[0..i - 1]
    middle = deck[i..j]
    right = deck[j + 1..deck.size - 1]

    right + middle + left
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