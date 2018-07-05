require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  string = string.chars
  string_hash = HashMap.new

  string.each do |ch|
    if string_hash[ch]
      string_hash[ch] += 1
    else
      string_hash[ch] = 1
    end
  end
  odd_count_chars = 0
  string_hash.each do |ch,count|
  odd_count_chars += 1 if count % 2 == 1
  return false if odd_count_chars >  1
  end
  true
end
