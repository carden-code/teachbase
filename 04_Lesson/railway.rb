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
                ' 15 - Посмотреть список станций.',
                ' 16 - Посмотреть список поездов на станции.',
                BORDERLINE,
                '  0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end

  # Метод data_input принимает параметр печатает его
  # и запрашивает ввод пользователя, результат сохранят в @args.
  def data_input(message)
    @args = []
    message.each { |mess| puts mess }
    @args << gets.chomp
  end

  # Метод dublicate_name? проверяет на наличие дубликатов имен.
  def dublicate_name?(arr, name)
    arr.any? { |elem| elem.name == name.to_s }
  end

  # Метод create_station создаёт станцию.
  def create_station
    message = ['Введите название станции:']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@stations, name)

    @stations << Station.new(name)
  end

  # Метод create_train_pass может создавать пассажирский поезд.
  def create_train_pass
    message = ['Введите номер поезда:']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@trains, name)

    @trains << PassengerTrain.new(name)
  end

  # Метод create_train_cargo может создавать грузовой поезд.
  def create_train_cargo
    message = ['Введите номер поезда:']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@trains, name)

    @trains << CargoTrain.new(name)
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

  # Метод choose_a_train возвращает выбранный пользователем поезд.
  def choose_a_train
    message = @trains
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }

    message = ['Выбрать поезд: ']
    index = data_input(message).first.to_i - 1
    @trains[index]
  end

  # Метод attach_wagon прицепляет вагон к поезду и удаляет из @wagons.
  def attach_wagon
    return if @trains.size.zero? || @wagons.size.zero?

    train = choose_a_train

    suitable_wagon = @wagons.select { |wagon| wagon.type == train.type }.first

    return if suitable_wagon.nil?

    train.attach_wagon(suitable_wagon)
    @wagons.delete(suitable_wagon)
  end

  # Метод detach_wagon отцепляет вагон от поезда и добавляет в @wagons.
  def detach_wagon
    return if @trains.size.zero? || @wagons.size.zero?

    train = choose_a_train

    return if train.wagons.size.zero?

    @wagons << train.detach_wagon
  end

  # Метод selected_station_route может выводить список станций
  # и запрашивает ввод пользователя для выбора станции.
  def selected_station_route
    message = @stations
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }

    message = ['Выбрать станцию: ']
    index = data_input(message).first.to_i - 1
    @stations[index]
  end

  # Метод create_route может создавать маршрут из двух выбранных станций.
  def create_route
    return if @stations.size < 2

    p 'Выберете начальную станцию для маршрута:'
    first = selected_station_route
    p 'Выберете конечную станцию для маршрута:'
    last = selected_station_route
    @routes << Route.new(first, last) if first != last
  end

  # Метод selected_route может выбирать из списка маршрут.
  def selected_route
    message = @routes
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }

    message = ['Выбрать маршрут: ']
    index = data_input(message).first.to_i - 1
    @routes[index]
  end

  # Метод add_station может добавлять промежуточную станцию в маршрут.
  def add_station
    return if @routes.size.zero?
    p 'Введите номер маршрута в который хотите добавить станцию:'
    route = selected_route

    return if route.nil?

    p 'Введите название станции:'
    route.midway(selected_station_route)
  end

  # Метод delete_midway может удалять промежуточную станцию.
  def delete_midway
    return if @routes.size.zero?

    p 'Введите номер маршрута из котороко нужно удалить станцию:'
    route = selected_route

    return if route.nil?

    p 'Введите номер станции которую хотите удалить из маршрута:'
    station = selected_station_route

    return if station == (route.stations.first && route.stations.last)

    route.delete_midway(station)
  end

  # Метод add_route_train может назначать маршрут поезду.
  def add_route_train
    return if @trains.size.zero? || @routes.size.zero?

    p 'Введите номер поезда для которого нужно назначить маршрут:'
    train = choose_a_train
    p 'Введите номер маршрута который хотите назначить поезду:'
    route = selected_route
    train.route(route)
  end

  # Метод move_forwards может перемещать поезд вперед на одну станцию.
  def move_forwards
    return if @trains.size.zero?
    p 'Введите номер поезда который нужно переместить на станцию вперед:'
    choose_a_train.move_forwards
  end

  # Метод move_backwards может перемещать поезд назад на одну станцию.
  def move_backwards
    return if @trains.size.zero?
    p 'Введите номер поезда который нужно переместить на станцию назад:'
    choose_a_train.move_backwards
  end

  # Метод list_stations может выводить список станций.
  def list_stations
    @stations.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
  end

  # Метод list_trains_station может выводить список поездов на станции.
  def list_trains_station
    return if @stations.size.zero?
    p 'Введите номер станции на которой хотите посмотреть список поездов.'
    station = selected_station_route
    p "Список поездов на станции: #{station.trains}"
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
      move_forwards
    when '14'
      move_backwards
    when '15'
      list_stations
    when '16'
      list_trains_station
    else
      puts 'Повторите ввод!'
    end
  end
end
