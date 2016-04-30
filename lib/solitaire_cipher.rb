require 'deck_of_cards'

class SolitaireCipher
  attr_reader :deck

  def initialize(deck)
    @deck = deck
    @deck_logic = DeckOfCards.new
  end

  def encode(input_string)
    clean_input            = prepare_input(input_string)
    keystream              = prepare_input(@deck_logic.obtain_keystream(clean_input.size, deck))

    message_numbers        = letters_to_numbers(clean_input)
    keystream_numbers      = letters_to_numbers(keystream)
    message_plus_keystream = add_keys_and_wrap(message_numbers, keystream_numbers)
    coded_message          = split_into_groups_of_5(numbers_to_letters(message_plus_keystream))
  end

  def prepare_input(string)
    partial_result = keep_letters_and_upcase(string)
    # split_in_groups_and_pad(partial_result)
    letters = split_into_letters(partial_result)
    pad_to_multiple_of_5(letters)
  end

  def keep_letters_and_upcase(string)
    string.upcase.gsub(/[^A-Z]/, '')
  end

  def split_into_letters(string)
    string.split('')
  end

  def pad_to_multiple_of_5(letters)
    modulo_leftover = letters.size % 5
    pads_needed = modulo_leftover == 0 ? 0 : 5 - modulo_leftover
    pads_needed.times do
      letters << 'X'
    end
    letters
  end

  def split_into_groups_of_5(string)
    string.scan(/.{1,5}/).join(' ')
  end

  def letters_to_numbers(letters)
    letters.map { |letter| letter.ord - 'A'.ord + 1 }
  end

  def numbers_to_letters(numbers)
    # FIXME: move this method to the module
    numbers.map { |number| wrap_and_convert_to_letter(number) }.join
  end

  def wrap_and_convert_to_letter(n)
    convert_to_letter(wrap_after_26(n))
  end

  def convert_to_letter(number)
    (number + 'A'.ord - 1).chr
  end

  def add_keys_and_wrap(first_array, second_array)
    first_array.zip(second_array).map {|(m,n)| wrap_after_26(m+n) }
  end

  def wrap_after_26(number)
    if number > 26
      number - 26
    else
      number
    end
  end
end
