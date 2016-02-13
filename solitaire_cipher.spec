require 'rspec'

describe "solitaire cipher" do
  describe "#encode" do
    it "returns the encoded text" do
      pending
      expect(encode("CODEI NRUBY LIVEL ONGER")).to eq "GLNCQ MJAFF FVOMB JIYCB"
    end
  end

  describe "#prepare_input" do
    it "sanitizes, upcases, splits and pads the input string" do
      expect(prepare_input("CodIng\nIn Ru8y;is 4Un! YeY")).to eq "CODIN GINRU YISUN YEYXX"
    end
  end

  describe "#keep_letters_and_upcase" do
    it "should remove any non letter charaters and upcase all letters" do
      expect(keep_letters_and_upcase("abc4 def\n ,!XY; z")).to eq "ABCDEFXYZ"
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
end

def encode(input_string)
end

def prepare_input(string)
  partial_result = keep_letters_and_upcase(string)
  split_in_groups_and_pad(partial_result)
end

def keep_letters_and_upcase(string)
  string.upcase.gsub(/[^A-Z]/, '')
end

def split_in_groups_and_pad(input)
  groups = input.scan(/.{1,5}/)
  groups[-1] = groups[-1].ljust(5,"X")
  groups.join(' ')
end
