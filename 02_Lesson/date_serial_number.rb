# The program requests the date month and year and displays the serial number.
puts 'Please enter date, month, year.'
puts 'Date:'
date = gets.chomp.to_i
puts 'Month:'
month = gets.chomp.to_i
puts 'Year:'
year = gets.chomp.to_i
arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
arr[1] = 29 if ((year % 4).zero? && year % 100 != 0) || (year % 400).zero?
sum = arr.take(month - 1).sum
puts "Date entered: #{date}.#{month}.#{year}"
puts "Date serial number: #{date + sum}"
