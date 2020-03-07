# The program fills the hash with vowels, where the value will be
# the serial number of the letter in the alphabet.
hash = {}
alphabet = ('a'..'z').to_a
volwes = %w[a e i o u]
alphabet.each.with_index(1) { |e, i| hash[e] = i if volwes.include? e }
puts hash
