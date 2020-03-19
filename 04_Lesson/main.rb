require_relative 'train'
require_relative 'route'
require_relative 'wagon'
require_relative 'station'
require_relative 'railway'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

railway = Railway.new
puts "Добро пожаловать в программу 'Железная дорога'"
loop do
  railway.menu
  input = gets.chomp
  break if input == '0'
end
