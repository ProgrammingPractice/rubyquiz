class DeckOfCards
  JOKER_A = "a"
  JOKER_B = "b"

  def move_joker_A_down(deck)
    i = deck.index(JOKER_A)
    deck.delete_at(i)
    if i == deck.size
      i = -1
    end
    deck.insert(i + 1, JOKER_A)
  end

  def move_joker_B_down(deck)
    i = deck.index(JOKER_B)
    deck.delete_at(i)
    if i >= deck.size - 1
      i = i - deck.size - 1
    end
    deck.insert(i + 2, JOKER_B)
  end
end