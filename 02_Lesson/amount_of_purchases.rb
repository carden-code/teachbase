# The program asks for the name of the product, value, number and display
# of products in the basket, the total value of each product and
# the total value of all products in the basket.
basket = {}
total = {}
grand_total = 0
loop do
  puts 'Please enter the name of the product, price and quantity.'
  puts 'Product Name:'
  name = gets.chomp
  puts 'Сost of goods:'
  price = gets.chomp.to_f
  puts 'Quantity:'
  quantity = gets.chomp.to_i
  basket[name] = { price => quantity }
  total[name] = price * quantity
  puts 'If there are no more products, enter “stop”, if there is, press “Enter”'
  break if gets.chomp == 'stop'
end
total.each_value { |value| grand_total += value }
puts "Your items in the basket: #{basket}"
puts "Total cost of goods: #{total}"
puts "The total amount of all purchases in the basket: #{grand_total}"
