#
require_relative 'train'
require_relative 'route'
require_relative 'wagon'
require_relative 'station'
require_relative 'railway'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

BORDERLINE = '-' * 50

#
railway = Railway.new

puts "Добро пожаловать в программу 'Железная дорога'"

#
loop do
  railway.menu_items

  menu_item = gets.chomp
  break if menu_item == '0'

  railway.selected(menu_item)
end
