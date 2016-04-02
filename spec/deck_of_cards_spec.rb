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

  describe "#triple_cut_around_jokers" do
    it "swaps the cards 'outside' the jokers" do
      expect(deck.triple_cut_around_jokers([1, 2, j1, 3, j2, 4])).to eq [4, j1, 3, j2, 1, 2]
    end

    it "does not assume that Joker A is the first one" do
      expect(deck.triple_cut_around_jokers([1, j2, 2, j1, 3])).to eq [3, j2, 2, j1, 1]
    end

    it "handles special cases for joker positions" do
      expect(deck.triple_cut_around_jokers([j1, 1, j2, 2])).to eq [2, j1, 1, j2]
      expect(deck.triple_cut_around_jokers([1, j1, 2, j2])).to eq [j1, 2, j2, 1]
      expect(deck.triple_cut_around_jokers([1, j1, j2, 2])).to eq([2, j1, j2, 1])
    end
  end

  describe "#perform_count_cut" do
    it "uses the last card as a count for where to perform the cut" do
      expect(deck.perform_count_cut([5, 6, 7, 8, 9, 2])).to eq [7, 8, 9, 5, 6, 2]
    end

    it "leaves the deck unchanged when the last card is a Joker" do
      expect(deck.perform_count_cut([1, 2, 3 , j1])).to eq [1, 2, 3 , j1]
    end
  end

  describe "#obtain_letter" do
    it "returns the letter value of the card at position calculated from first card" do
      expect(deck.obtain_letter([2, 3, 26])).to eq 'Z'
    end

    it "does not return a letter if the output card is a joker" do
      expect(deck.obtain_letter([1, j1])).to eq ''
    end

    it "returns the 54th card when first card is a joker" do
      expect(deck.obtain_letter([[j1] + (1..52).to_a + [2]])).to eq 'B'
    end
  end
end
