class DeckOfCards
  JOKER_A = "a"
  JOKER_B = "b"

  def move_joker_A_down(deck)
    move_card_down(deck, JOKER_A, 1)
  end

  def move_joker_B_down(deck)
    move_card_down(deck, JOKER_B, 2)
  end

  private

  def move_card_down(deck, card, positions)
    i = deck.index(card)
    deck.delete_at(i)
    if i >= deck.size - positions + 1
      i = i - deck.size - 1
    end
    deck.insert(i + positions, card)
  end
end