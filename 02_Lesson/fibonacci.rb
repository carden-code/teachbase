# The program fills the array with fibonacci numbers up to 100.
fibonacci = [0, 1]
next_element = 1
while next_element <= 100
  fibonacci << next_element
  next_element = fibonacci[-1] + fibonacci[-2]
end
puts "Fibonacci numbers up to 100: #{fibonacci}"
