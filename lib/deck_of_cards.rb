class DeckOfCards
  JOKER_A = "a"

  def move_joker_A_down(deck)
    i = deck.index(JOKER_A)
    deck.delete_at(i)
    if i == deck.size
      i = -1
    end
    deck.insert(i + 1, JOKER_A)
  end
end