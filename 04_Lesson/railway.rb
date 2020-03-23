# Класс Railway (Железная дорога) может:
# Выводить меню
# Создавать станции
# Создавать поезда
# Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# Назначать маршрут поезду
# Добавлять вагоны к поезду
# Отцеплять вагоны от поезда
# Перемещать поезд по маршруту вперед и назад
# Просматривать список станций и список поездов на станции
class Railway
  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = []
    @wagons = []
    @stations = []
  end

  # Метод menu_items выводит элементы массива,
  # которые являются пользовательским меню.
  def menu_items
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Создать станцию.',
                ' 2 - Создать пассажирский поезд.',
                ' 3 - Создать грузовой поезд.',
                ' 4 - Создать пассажирский вагон.',
                ' 5 - Создать грузовой вагон.',
                ' 6 - Посмотреть список вагонов.',
                ' 7 - Прицепить вагон к поезду.',
                ' 8 - Отцепить вагон от поезда.',
                ' 9 - Создать маршрут.',
                ' 10 - Добавить промежуточную станцию в маршрут.',
                ' 11 - Удалить промежуточную станцию из маршрута.',
                ' 12 - Назначить маршрут поезду.',
                ' 13 - Переместить поезд по маршруту вперед.',
                ' 14 - Переместить поезд по маршруту назад.',
                BORDERLINE,
                '  0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end

  # Метод data_input принимает параметр печатает его.
  # и запрашивает ввод пользователя, результат сохранят в @args.
  def data_input(message)
    @args = []
    message.each { |mess| puts mess }
    @args << gets.chomp
  end

  # Метод dublicate_name? проверяет на наличие дубликатов имен.
  def dublicate_name?(arr, name)
    arr.each { |elem| return true if elem.name == name.to_s }
    false
  end

  # Метод create_station создаёт станцию.
  def create_station
    message = ['Введите название станции:']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@stations, name)

    @stations << Station.new(name)
  end

  # Метод dublicate_name? проверяет на наличие дубликатов номера.
  def dublicate_number?(arr, number)
    arr.each { |elem| return true if elem.number == number.to_s }
    false
  end

  # Метод create_train_pass может создавать пассажирский поезд.
  def create_train_pass
    message = ['Введите номер поезда:']
    number = data_input(message).first

    return unless number != '' && !dublicate_number?(@trains, number)

    @trains << PassengerTrain.new(number)
  end

  # Метод create_train_cargo может создавать грузовой поезд.
  def create_train_cargo
    message = ['Введите номер поезда:']
    number = data_input(message).first

    return unless number != '' && !dublicate_number?(@trains, number)

    @trains << CargoTrain.new(number)
  end

  # Метод create_wagon_pass может создавать пассажирский вагон.
  def create_wagon_pass
    @wagons << PassengerWagon.new
  end

  # Метод create_wagon_cargo может создавать грузовой вагон.
  def create_wagon_cargo
    @wagons << CargoWagon.new
  end

  # Метод list_wagons может выводить список вагонов.
  def list_wagons
    @wagons.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
  end

  #def attach_wagon
  #  message = @trains
  #  message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
  #  index = data_input(message).first.to_i - 1
  #  puts "\n\nindex: #{index}"
  #  selected_train = @trains[index]
  #  puts "Selected train: #{selected_train}"
  #  selected_train.attach_wagon(@wagons.first)
  #end

  # Метод selected_train может выбирать поезд из списка.
  def selected_train
    message = @trains
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    index = data_input(message).first.to_i - 1
    puts "\n\nindex: #{index}"
    @selected_train = @trains[index]
    puts "Selected train: #{@selected_train}"
  end

  # Метод selected_wagon может выбирать вагон из списка.
  def selected_wagon
    message = @wagons
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    index = data_input(message).first.to_i - 1
    puts "\n\nindex: #{index}"
    @selected_wagon = @wagons[index]
    puts "Selected wagon: #{@selected_wagon}"
  end

  # Метод attach_wagon добавляет выбранный вагон к выбранному поезду
  # и удаляет вагон из @wagons.
  def attach_wagon
    p 'Введите соответствующий номер для выбора поезда:'
    selected_train
    p 'Выберете вагон из списка для прицепки к поезду (Должен совпадать Type ):'
    selected_wagon
    @selected_train.attach_wagon(@selected_wagon)
    @wagons.delete(@selected_wagon)
  end

  # Метод detach_wagon отцепляет вагон от поезда и добавляет в @wagons.
  def detach_wagon
    p 'Введите номер поезда у которого нужно отцепить вагон:'
    selected_train
    @wagons.push(@selected_train.detach_wagon)
  end

  # Метод selected_station_route может выводить список станций
  # и запрашивает ввод пользователя для выбора станции.
  def selected_station_route
    message = @stations
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    index = data_input(message).first.to_i - 1
    puts "\n\nindex: #{index}"
    @selected_station = @stations[index]
    puts "Selected station: #{@selected_station}"
  end

  # Метод create_route может создавать маршрут из двух выбранных станций.
  def create_route
    p 'Выберете начальную станцию для маршрута:'
    selected_station_route
    first = @selected_station
    p 'Выберете конечную станцию для маршрута:'
    selected_station_route
    last = @selected_station
    @routes << Route.new(first, last) if first != last
  end

  # Метод selected_route может выбирать из списка маршрут.
  def selected_route
    message = @routes
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    index = data_input(message).first.to_i - 1
    puts "\n\nindex: #{index}"
    @selected_route = @routes[index]
    puts "Selected route: #{@selected_route}"
  end

  # Метод add_station может добавлять промежуточную станцию в маршрут.
  def add_station
    p 'Введите номер маршрута в который хотите добавить станцию:'
    selected_route
    p 'Введите название станции:'
    input = Station.new(gets.chomp)
    @stations.insert(-2, input) unless @stations.include? input
    @selected_route.midway(input)
  end

  # Метод delete_midway может удалять промежуточную станцию.
  def delete_midway
    p 'Введите номер маршрута из котороко нужно удалить станцию:'
    selected_route
    p 'Введите номер станции которую хотите удалить из маршрута:'
    selected_station_route
    @selected_route.delete_midway(@selected_station)
    #@stations.delete(@selected_station) под вопросом.....
  end

  # Метод add_route_train может назначать маршрут поезду.
  def add_route_train
    p 'Введите номер поезда для которого нужно назначить маршрут:'
    selected_train
    p 'Введите номер маршрута который хотите назначить поезду:'
    selected_route
    @selected_train.route(@selected_route)
  end

  # Метод move_forwards может перемещать поезд вперед на одну станцию.
  def move_forwards
    p 'Введите номер поезда который нужно переместить на станцию вперед:'
    selected_train
    @selected_train.move_forwards
  end

  # Метод move_backwards может перемещать поезд назад на одну станцию.
  def move_backwards
    p 'Введите номер поезда который нужно переместить на станцию назад:'
    selected_train
    @selected_train.move_backwards
  end


  # Метод selected принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
  def selected(menu_item)
    puts "Your choice: #{menu_item}" if menu_item != ''

    case menu_item
    when '1'
      create_station
    when '2'
      create_train_pass
    when '3'
      create_train_cargo
    when '4'
      create_wagon_pass
    when '5'
      create_wagon_cargo
    when '6'
      list_wagons
    when '7'
      attach_wagon
    when '8'
      detach_wagon
    when '9'
      create_route
    when '10'
      add_station
    when '11'
      delete_midway
    when '12'
      add_route_train
    when '13'

    else
      puts 'Повторите ввод!'
    end
  end
end
