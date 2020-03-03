# The program asks the user for a name and height and displays the ideal weight
# according to the formula, after which it displays the result to the user
# on the screen with a call by name.
puts 'Please write your name:'
name = gets.chomp
puts 'Please indicate your height:'
height = gets.chomp.to_i
ideal_weight = (height - 110) * 1.15
if ideal_weight.negative?
  puts 'Your weight is already optimal'
else
  puts "#{name}, your ideal weight - #{ideal_weight} kg."
end
