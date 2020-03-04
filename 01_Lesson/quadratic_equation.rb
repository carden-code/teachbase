# The user enters 3 coefficients a, b and c. The program calculates
# the discriminant and the roots of the equation (if any) and displays
# the values ​​of the discriminant and roots on the screen.
puts 'Please enter three coefficients.'
puts 'First coefficient:'
a = gets.chomp.to_f
puts 'Second coefficient:'
b = gets.chomp.to_f
puts 'Third coefficient:'
c = gets.chomp.to_f
dis = b**2 - (4 * a * c)
if dis.negative?
  puts "Discriminant: #{dis}"
  puts 'No roots.'
elsif dis.positive?
  sqr = Math.sqrt(dis)
  puts "Diskriminant: #{dis}"
  puts "First root of the equation: #{- b + sqr / 2 * a}"
  puts "Second root of the equation: #{- b - sqr / 2 * a}"
elsif dis.zero?
  puts "Diskriminant: #{dis}"
  puts "Single root of the equation: #{- b / 2 * a}"
end
