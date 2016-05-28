require 'rspec'
require_relative '../lib/deck_of_cards'

describe DeckOfCards do
  let(:j1) { DeckOfCards::JOKER_A }
  let(:j2) { DeckOfCards::JOKER_B }

  def deck(cards)
    DeckOfCards.new(cards)
  end

  describe "#obtain_keystream" do
    it "returns a keystream of n elements" do
      expect(deck((1..52).to_a + [j1, j2]).obtain_keystream(10)).to eq 'DWJXHYRFDG'
    end
  end

  describe "#move_joker_A_down" do
    it "moves joker A down one position" do
      expect(deck([j1, 1, 2, 3]).move_joker_A_down).to eq [1, j1, 2, 3]
    end

    it "moves the joker A below the top card when it is the last card" do
      expect(deck([1, 2, 3, j1]).move_joker_A_down).to eq [1, j1, 2, 3]
    end
  end

  describe "#move_joker_B_down" do
    it "moves joker B down two positions" do
      expect(deck([j2, 1, 2, 3]).move_joker_B_down).to eq [1, 2, j2, 3]
    end

    it "moves the joker B below the top card when it is right above the last card" do
      expect(deck([1, 2, j2, 3]).move_joker_B_down).to eq [1, j2, 2, 3]
    end

    it "moves the joker B to third position of deck when it the last card" do
      expect(deck([1, 2, 3, j2]).move_joker_B_down).to eq [1, 2, j2, 3]
    end
  end

  describe "#perform_triple_cut" do
    it "swaps the cards 'outside' the jokers" do
      expect(deck([1, 2, j1, 3, j2, 4]).perform_triple_cut).to eq [4, j1, 3, j2, 1, 2]
    end

    it "does not assume that Joker A is the first one" do
      expect(deck([1, j2, 2, j1, 3]).perform_triple_cut).to eq [3, j2, 2, j1, 1]
    end

    it "handles special cases for joker positions" do
      expect(deck([j1, 1, j2, 2]).perform_triple_cut).to eq [2, j1, 1, j2]
      expect(deck([1, j1, 2, j2]).perform_triple_cut).to eq [j1, 2, j2, 1]
      expect(deck([1, j1, j2, 2]).perform_triple_cut).to eq([2, j1, j2, 1])
    end
  end

  describe "#perform_count_cut" do
    it "uses the last card as a count for where to perform the cut" do
      expect(deck([5, 6, 7, 8, 9, 2]).perform_count_cut).to eq [7, 8, 9, 5, 6, 2]
    end

    it "leaves the deck unchanged when the last card is a Joker" do
      expect(deck([1, 2, 3 , j1]).perform_count_cut).to eq [1, 2, 3 , j1]
    end
  end

  describe "#obtain_letter" do
    it "returns the letter value of the card at position calculated from first card" do
      expect(deck([2, 3, 26]).obtain_letter).to eq 'Z'
    end

    it "does not return a letter if the output card is a joker" do
      expect(deck([1, j1]).obtain_letter).to eq ''
    end

    it "returns the 54th card when first card is a joker" do
      cards = [j1] + (1..52).to_a + [2]
      expect(deck(cards).obtain_letter).to eq 'B'
    end
  end

  describe "#letters_to_numbers" do
    it "converts the letters to numbers" do
      expect(deck(nil).letters_to_numbers('ABCDEXYZ'.split(''))).to eq [1, 2, 3, 4, 5, 24, 25, 26]
    end
  end

  describe "#numbers_to_letters" do
    it "converts numbers to letters" do
      expect(deck(nil).numbers_to_letters([1, 2, 3, 10, 11, 24, 25, 26])).to eq 'ABCJKXYZ'
    end

    it "wraps around when alphabet length exceded" do
      expect(deck(nil).numbers_to_letters([27])).to eq 'A'
    end
  end

  describe "#wrap_after_26" do
    it "substracts 26 if number greater than 26" do
      expect(deck(nil).wrap_after_26(1)).to eq 1
      expect(deck(nil).wrap_after_26(26)).to eq 26
      expect(deck(nil).wrap_after_26(27)).to eq 1
    end
  end
end
