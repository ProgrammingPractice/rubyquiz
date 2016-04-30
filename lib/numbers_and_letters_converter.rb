module NumbersAndLettersConverter
  def self.number_to_letter(number)
    SolitaireCipher.new(nil).numbers_to_letters([number])
  end
end
