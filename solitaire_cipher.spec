require 'rspec'

describe "solitaire cipher" do
  subject { encode("CODEI NRUBY LIVEL ONGER") }

  it "returns the encoded text" do
    should == "GLNCQ MJAFF FVOMB JIYCB"
  end

  it "should remove any non letter charaters" do
    expect(encode("Code in Ruby, live longer!")).to eq "CODEI NRUBY LIVEL ONGER"
  end
end

def encode(input_string)
  input_string.gsub(/\W/, "").upcase
end