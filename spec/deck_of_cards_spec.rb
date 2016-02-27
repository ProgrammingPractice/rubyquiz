require 'rspec'
require_relative '../lib/deck_of_cards'

describe DeckOfCards do
  let(:deck_of_cards) { DeckOfCards.new }

  describe "#move_joker_A" do
    let(:shuffeled_deck_of_cards) { (1..52).to_a + ["a", "b"] }

    it "moves A joker 1 position down" do
      expect(deck_of_cards.move_joker_A(shuffeled_deck_of_cards)).to eq (1..52).to_a + ["b","a"]
    end
  end
end