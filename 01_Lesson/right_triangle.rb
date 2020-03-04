# The program asks the user for 3 sides of the triangle
# and determines which triangle it is.
puts 'Please enter 3 sides of the triangle.'
arr = []
puts 'First side:'
arr << gets.chomp.to_f
puts 'Second side:'
arr << gets.chomp.to_f
puts 'Third side:'
arr << gets.chomp.to_f
first, second = arr.min(2)
hyp = arr.max
if first == second && first == hyp
  puts 'Triangle isosceles and equilateral.'
elsif first == second || first == hyp || second == hyp
  puts 'Isosceles triangle.'
elsif hyp**2 == first**2 + second**2
  puts 'Right triangle.'
else
  puts 'Triangle versatile.'
end
