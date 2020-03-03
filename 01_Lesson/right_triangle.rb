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
arr.sort
gipotenuza = arr.last
if arr[0] == arr[1] && arr[1] == arr[2] && arr[2] == arr[0]
  puts 'Triangle isosceles and equilateral.'
elsif arr[0] == arr[1] || arr[1] == arr[2] || arr[2] == arr[0]
  puts 'Isosceles triangle.'
elsif gipotenuza**2 == arr.first**2 + arr[1]**2
  puts 'Right triangle.'
else
  puts 'Triangle versatile.'
end
