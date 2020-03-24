# Подгруженные файлы (Классы)(модули)sssssдсСsssss
require_relative 'train'
require_relative 'route'
require_relative 'wagon'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'railway'

BORDERLINE = '-' * 50
NEWLINE = "\n" * 2

# Создаёт экземпляр класса Railway и выводит приветственное сообщение.
railway = Railway.new
puts NEWLINE
puts "Добро пожаловать в программу 'Железная дорога'"
puts NEWLINE
# Запуск меню (Цикл). С запросом ввода нужного пользователю пункта
# и передаёт результат в класс.
loop do
  puts "stations: #{railway.stations}\n\n"
  puts "trains: #{railway.trains}\n\n"
  puts "wagons: #{railway.wagons}\n\n"
  puts "routes: #{railway.routes}\n\n"
  puts NEWLINE
  railway.menu_items

  menu_item = gets.chomp
  break if menu_item == '0'

  railway.selected(menu_item)
end
