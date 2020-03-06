# The program requests the date month and year and displays the serial number.
puts 'Please enter date, month, year.'
puts 'Date:'
date = gets.chomp.to_i
puts 'Month:'
month = gets.chomp.to_i
puts 'Year:'
year = gets.chomp.to_i
hash = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
         7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }
hash[2] = 29 if ((year % 4).zero? && year % 100 != 0) || (year % 400).zero?
sum = 0
if month > 0
  hash.each do |kay, value|
    sum += value
    break if kay == month - 1
  end
  date + sum
end
puts "Date entered: #{date}.#{month}.#{year}"
puts "Date serial number: #{date + sum}"
