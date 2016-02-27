class SolitaireCipher
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

  def letters_to_numbers(string)
    string.split(' ').map do |s|
      s.split('').map { |c| c.ord - 'A'.ord + 1 }
    end
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
