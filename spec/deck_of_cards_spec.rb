require 'rspec'
require_relative '../lib/deck_of_cards'

describe DeckOfCards do
  let(:j1) { DeckOfCards::JOKER_A }
  let(:j2) { DeckOfCards::JOKER_B }

  let(:deck) { DeckOfCards.new }

  describe "#move_joker_A_down" do
    it "moves joker A down one position" do
      expect(deck.move_joker_A_down([j1, 1, 2, 3])).to eq [1, j1, 2, 3]
    end

    it "moves the joker A to top of deck when it is the last card" do
      expect(deck.move_joker_A_down([1, 2, 3, j1])).to eq [j1, 1, 2, 3]
    end
  end

  describe "#move_joker_B_down" do
    it "moves joker B down two positions" do
      expect(deck.move_joker_B_down([j2, 1, 2, 3])).to eq [1, 2, j2, 3]
    end

    it "moves the joker B to top of deck when it is right above the last card" do
      expect(deck.move_joker_B_down([1, 2, j2, 3])).to eq [j2, 1, 2, 3]
    end

    it "moves the joker B to second position of deck when it the last card" do
      expect(deck.move_joker_B_down([1, 2, 3, j2])).to eq [1, j2, 2, 3]
    end
  end
end
