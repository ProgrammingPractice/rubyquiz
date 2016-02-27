require 'rspec'
require_relative '../lib/deck_of_cards'

describe DeckOfCards do
  let(:j1) { DeckOfCards::JOKER_A }

  let(:deck) { DeckOfCards.new }

  describe "#move_joker_A_down" do
    it "moves joker A down one position" do
      expect(deck.move_joker_A_down([j1, 1, 2, 3])).to eq [1, j1, 2, 3]
    end

    it "moves the joker A to top of deck when it is the last card" do
      expect(deck.move_joker_A_down([1, 2, 3, j1])).to eql [j1, 1, 2, 3]
    end
  end
end
