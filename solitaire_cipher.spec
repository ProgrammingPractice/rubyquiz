require 'rspec'

describe "solitaire cipher" do
  describe "#encode" do
    it "returns the encoded text" do
      pending
      expect(encode("CODEI NRUBY LIVEL ONGER")).to eq "GLNCQ MJAFF FVOMB JIYCB"
    end
  end

  describe "#keep_letters_and_upcase" do
    it "should remove any non letter charaters and upcase all letters" do
      expect(keep_letters_and_upcase("Code in Ruby, live longer!")).to eq "CODEINRUBYLIVELONGER"
    end
  end

  describe "#split_in_groups_and_pad" do
    it "creates groups of 5 characters" do
      expect(split_in_groups_and_pad('abcdefghij')).to eq 'abcde fghij'
    end

    it "padds the last group with X's" do
      expect(split_in_groups_and_pad('abcdefg')).to eq 'abcde fgXXX'
    end
  end

  # expect(encode("Code in Ruby, live longer!")).to eq "CODEI NRUBY LIVEL ONGER"
end

def encode(input_string)
end

def keep_letters_and_upcase(string)
  string.gsub(/\W/, "").upcase
end

def split_in_groups_and_pad(input)
  groups = input.scan(/.{1,5}/)
  groups[-1] = groups[-1].ljust(5,"X")
  groups.join(' ')
end
