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
  HASH = { '1' => :create_station, '2' => :create_train_pass,
           '3' => :create_train_cargo, '4' => :create_wagon_pass,
           '5' => :create_wagon_cargo, '6' => :list_wagons,
           '7' => :attach_wagon, '8' => :detach_wagon, '9' => :create_route,
           '10' => :add_station, '11' => :delete_midway,
           '12' => :add_route_train, '13' => :move_forwards,
           '14' => :move_backwards, '15' => :list_stations,
           '16' => :ist_trains_station, '17' => :list_wagons_train,
           '18' => :take_the_place_wagon }.freeze

  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = []
    @wagons = []
    @stations = []
  end

  # rubocop:disable Metrics/MethodLength
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
                ' 17 - Посмотреть список вагонов у поезда.',
                ' 18 - Наполнить вагон.',
                BORDERLINE,
                '  0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end
  # rubocop:enable Metrics/MethodLength

  # Метод message_re_enter выводит сообщение.
  def message_re_enter
    puts 'Повторите ввод!'
  end

  # Метод selected принимает параметр из пользовательского ввода
  # и исполняет соответствующий метод.
  def selected(menu_item)
    send HASH[menu_item]
  rescue TypeError
    message_re_enter
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

    return if dublicate_name?(@stations, name)

    @stations << Station.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  # Метод info_train_created выводит сообщение.
  def info_created
    puts 'Успешно!'
  end

  # Метод error_message выводит аргумент.
  def error_message(e)
    puts e
  end

  # Метод create_train_pass может создавать пассажирский поезд.
  def create_train_pass
    message = ['Введите номер поезда: Пример(12345; 123-AA; ccc-99; 1af-0a)']
    name = data_input(message).first

    return if dublicate_name?(@trains, name)

    @trains << PassengerTrain.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  # Метод create_train_cargo может создавать грузовой поезд.
  def create_train_cargo
    message = ['Введите номер поезда: Пример(12345; 123-AA; ccc-99; 1af-0a)']
    name = data_input(message).first

    return if dublicate_name?(@trains, name)

    @trains << CargoTrain.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  # Метод create_wagon_pass может создавать пассажирский вагон.
  def create_wagon_pass
    message = ['Введите количество мест в вагоне:']
    name = data_input(message).first

    @wagons << PassengerWagon.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  # Метод create_wagon_cargo может создавать грузовой вагон.
  def create_wagon_cargo
    message = ['Введите объем грузового вагона:']
    name = data_input(message).first

    @wagons << CargoWagon.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  # Метод list_wagons может выводить список вагонов.
  def list_wagons
    @wagons.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
  end

  # Метод choose_a_train возвращает выбранный пользователем поезд.
  def choose_a_train
    message = @trains
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem.name}" }

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
    return if @trains.size.zero?

    train = choose_a_train

    return if train.wagons.size.zero?

    @wagons << train.detach_wagon
  end

  # Метод selected_station_route может выводить список станций
  # и запрашивает ввод пользователя для выбора станции.
  def selected_station_route
    message = @stations
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem.name}" }

    message = ['Выбрать станцию: ']
    index = data_input(message).first.to_i - 1
    @stations[index]
  end

  # Метод choose_first_station выводит сообщение.
  def choose_first_station
    puts 'Выберете начальную станцию для маршрута:'
  end

  # Метод choose_last_station выводит сообщение.
  def choose_last_station
    puts 'Выберете конечную станцию для маршрута:'
  end

  # Метод create_route может создавать маршрут из двух выбранных станций.
  def create_route
    return if @stations.size < 2

    choose_first_station
    first = selected_station_route
    choose_last_station
    last = selected_station_route
    @routes << Route.new(first, last)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  # Метод selected_route может выбирать из списка маршрут.
  def selected_route
    message = @routes
    message.each_with_index { |elem, ind| puts "#{ind + 1}. #{elem.stations}" }

    message = ['Выбрать маршрут: ']
    index = data_input(message).first.to_i - 1
    @routes[index]
  end

  # Метод message_number_route_add_station выводит сообщение.
  def message_number_route_add_station
    puts 'Введите номер маршрута в который хотите добавить станцию:'
  end

  # Метод message_name_station_trains выводит сообщение.
  def message_name_station
    puts 'Введите название станции:'
  end

  # Метод add_station может добавлять промежуточную станцию в маршрут.
  def add_station
    return if @routes.size.zero? || @stations.size < 3

    message_number_route_add_station
    route = selected_route

    message_name_station
    route.midway(selected_station_route)
  end

  # Метод message_number_route_delete_station выводит сообщение.
  def message_number_route_delete_station
    puts 'Введите номер маршрута из которого нужно удалить станцию:'
  end

  # Метод message_number_station_delete выводит сообщение.
  def message_number_station_delete
    puts 'Введите номер станции которую хотите удалить из маршрута:'
  end

  # Метод delete_midway может удалять промежуточную станцию.
  def delete_midway
    return if @routes.size.zero? || @stations.size < 3

    message_number_route_delete_station
    route = selected_route

    message_number_station_delete
    station = selected_station_route

    return if station == (route.stations.first && route.stations.last)

    route.delete_midway(station)
  end

  # Метод message_number_add_route выводит сообщение.
  def message_number_add_route
    puts 'Введите номер поезда для которого нужно назначить маршрут:'
  end

  # Метод message_number_route_train выводит сообщение.
  def message_number_route_train
    puts 'Введите номер маршрута который хотите назначить поезду:'
  end

  # Метод add_route_train может назначать маршрут поезду.
  def add_route_train
    return if @trains.size.zero? || @routes.size.zero?

    message_number_add_route
    train = choose_a_train
    message_number_route_train
    route = selected_route
    train.route(route)
  end

  # Метод message_number_train_move_forwards выводит сообщение.
  def message_number_train_move_forwards
    puts 'Введите номер поезда который нужно переместить на станцию вперед:'
  end

  # Метод move_forwards может перемещать поезд вперед на одну станцию.
  def move_forwards
    return if @trains.size.zero?

    message_number_train_move_forwards
    choose_a_train.move_forwards
  end

  # Метод message_number_train_move_backwards выводит сообщение.
  def message_number_train_move_backwards
    puts 'Введите номер поезда который нужно переместить на станцию назад:'
  end

  # Метод move_backwards может перемещать поезд назад на одну станцию.
  def move_backwards
    return if @trains.size.zero?

    message_number_train_move_backwards
    choose_a_train.move_backwards
  end

  # Метод list_stations может выводить список станций.
  def list_stations
    @stations.each_with_index { |elem, index| puts "#{index + 1}.#{elem.name}" }
  end

  # Метод message_volume выводит сообщение.
  def message_volume
    puts 'Введите число (объем) на который хотите занять вагон:'
  end

  # Метод take_the_place_wagon может занимать место или объем в вагоне.
  def take_the_place_wagon
    return if @trains.size.zero?

    train = choose_a_train
    train.wagons.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    message = ['Выбрать вагон: ']
    index = data_input(message).first.to_i - 1

    if train.type == 'pass'
      train.wagons[index].take_seat
    elsif train.type == 'cargo'
      message_volume
      train.wagons[index].takes_volume(gets.chomp.to_i)
    end
  end

  # Метод message_list_wagons_train выводит сообщение.
  def message_list_wagons_train
    puts 'Выберете поезд для просмотра вагонов:'
  end

  # Метод list_wagons_train выводит список вагонов у поезда и
  # показывает тип вагона, вместимость и сколько места занято.
  def list_wagons_train
    return if @trains.size.zero?

    message_list_wagons_train

    train = choose_a_train
    train.list_wagons do |wagon, index|
      puts "Номер вагона: #{index + 1},
      Тип: #{wagon.type}
      Вместимость: #{wagon.capacity},
      Занято: #{wagon.occupied}"
    end
  end

  # Метод message_number_station_list_trains выводит сообщение.
  def message_number_station_list_trains
    puts 'Введите номер станции на которой хотите посмотреть список поездов.'
  end

  # Метод list_trains_station может выводить список поездов на станции.
  def list_trains_station
    return if @stations.size.zero?

    message_number_station_list_trains

    station = selected_station_route
    station.list_trains do |train|
      puts "Номер:#{train.name},Тип:#{train.type},Вагонов:#{train.wagons.size}"
    end
  end
end
