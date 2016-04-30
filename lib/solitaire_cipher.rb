class SolitaireCipher
  attr_reader :deck

  def initialize(deck)
    @deck = deck
    @deck_logic = DeckOfCards.new
  end

  def encode(input_string)
    clean_input = prepare_input(input_string)
    puts ">>>>>"
    puts clean_input
    keystream = @deck_logic.obtain_keystream(clean_input.size, deck)
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

  def letters_to_numbers(string)
    string.split(' ').map do |s|
      s.split('').map { |c| c.ord - 'A'.ord + 1 }
    end
  end

  def numbers_to_letters(numbers)
    # FIXME: move this method to the module
    numbers.map { |word| convert_a_word(word) }.join(' ')
  end

  def convert_a_word(word)
    word.map { |n| wrap_and_convert_to_letter(n) }.join
  end

  def wrap_and_convert_to_letter(n)
    convert_to_letter(wrap_after_26(n))
  end

  def convert_to_letter(number)
    (number + 'A'.ord - 1).chr
  end

  def add_keys_and_wrap(first_array, second_array)
    first_array.zip(second_array).map {|(a,b)| a.zip(b).map {|(m,n)| wrap_after_26(m+n) }}
  end

  def wrap_after_26(number)
    if number > 26
      number - 26
    else
      number
    end
  end

end
