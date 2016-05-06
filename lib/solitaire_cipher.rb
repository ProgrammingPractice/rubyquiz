require 'deck_of_cards'

class SolitaireCipher
  def initialize(deck)
    @deck = deck
  end

  def encode(message)
    clean_input            = prepare_input(message)
    keystream_string       = @deck.obtain_keystream(clean_input.size)
    keystream              = split_into_letters(keystream_string)

    message_numbers        = @deck.letters_to_numbers(clean_input)
    keystream_numbers      = @deck.letters_to_numbers(keystream)
    message_plus_keystream = add_keys_and_wrap(message_numbers, keystream_numbers)
    coded_message          = split_into_groups_of_5(@deck.numbers_to_letters(message_plus_keystream))
  end

  def prepare_input(string)
    partial_result = keep_letters_and_upcase(string)
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
    pads_needed = (-letters.size) % 5
    letters + ['X'] * pads_needed
  end

  def split_into_groups_of_5(string)
    string.scan(/.{1,5}/).join(' ')
  end

  def add_keys_and_wrap(first_array, second_array)
    first_array.zip(second_array).map {|(m,n)| @deck.wrap_after_26(m+n) }
  end
end
