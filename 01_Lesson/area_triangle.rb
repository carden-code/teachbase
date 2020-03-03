# The program asks the user for the base and height of the triangle
# and displays the area of ​​the triangle.
puts 'Please enter the base of the triangle:'
base = gets.chomp.to_f
puts 'Please enter the height of the triangle:'
height = gets.chomp.to_f
area_triangle = 0.5 * base * height
puts "Area of the triangle: #{area_triangle}"
