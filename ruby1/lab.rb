def words alphabet, len
  (1..(len-1)).inject(alphabet) {|words, useless| words.map{|word| alphabet.map{|letter| word + letter if word[-1] != letter}}.flatten.compact}
end
