require 'rspec'
require_relative '../lib/solitaire_cipher'

describe SolitaireCipher do
  let(:cipher) { SolitaireCipher.new(deck) }
  let(:deck) { nil }

  describe "#encode" do
    let(:deck) { (1..52).to_a + [DeckOfCards::JOKER_A] + [DeckOfCards::JOKER_B] }

    it "returns the encoded text" do
      message = "Code in Ruby! Live longer!"
      encoded = "GLNCQ MJAFF FVOMB JIYCB"
      expect(cipher.encode(message)).to eq encoded
    end
  end

  describe "#prepare_input" do
    it "sanitizes, upcases, splits and pads the input string" do
      expect(cipher.prepare_input("CodIng\nIn Ru8y;is 4Un! YeY")).to eq "CODINGINRUYISUNYEYXX".split('')
    end
  end

  describe "#keep_letters_and_upcase" do
    it "should remove any non letter charaters and upcase all letters" do
      expect(cipher.keep_letters_and_upcase("abc4 def\n ,!XY; z")).to eq "ABCDEFXYZ"
    end
  end

  describe "#pad_to_multiple_of_5" do
    it "should add two Xs at the end" do
      expect(cipher.pad_to_multiple_of_5(%w(a b c))).to eq %w(a b c X X)
    end

    it "should not add any Xs" do
      expect(cipher.pad_to_multiple_of_5(%w(a b c d e))).to eq %w(a b c d e)
    end
  end

  describe "#split_into_groups_of_5" do
    it "creates groups of 5 characters" do
      expect(cipher.split_into_groups_of_5('abcdefghij')).to eq 'abcde fghij'
    end
  end

  describe "#letters_to_numbers" do
    it "converts the letters to numbers" do
      expect(cipher.letters_to_numbers('ABCDEXYZ'.split(''))).to eq [1, 2, 3, 4, 5, 24, 25, 26]
    end
  end

  describe "#numbers_to_letters" do
    it "converts numbers to letters" do
      expect(cipher.numbers_to_letters([1, 2, 3, 10, 11, 24, 25, 26])).to eq 'ABCJKXYZ'
    end

    it "wraps around when alphabet length exceded" do
      expect(cipher.numbers_to_letters([27])).to eq 'A'
    end
  end

  describe "#add_keys_and_wrap" do
    it "adds keys pairwise and substracts 26 if result is above 26" do
      expect(cipher.add_keys_and_wrap([1,2,3,4,5,20,21], [5,4,3,2,1,6,6])).to eq [6,6,6,6,6,26,1]
    end
  end

  describe "#wrap_after_26" do
    it "substracts 26 if number greater than 26" do
      expect(cipher.wrap_after_26(1)).to eq 1
      expect(cipher.wrap_after_26(26)).to eq 26
      expect(cipher.wrap_after_26(27)).to eq 1
    end
  end
end
