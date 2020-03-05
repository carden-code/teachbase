puts 'Please enter date, month, year.'
puts 'Date:'
date = 22#gets.chomp.to_i
puts 'Month:'
month = 8#gets.chomp.to_i
puts 'Year:'
year = 2020#gets.chomp.to_i
sum_day = []
hash = { January: 31, February: 28, March: 31,
         April: 30, May: 31, June: 30,
         July: 31, August: 31, September: 30,
         October: 31, November: 30, December: 31 }
hash[:February] = 29 if (year % 4).zero? || (year % 400).zero?
sum_day = hash.each_value { |value| value += value }
#puts hash
puts sum_day
