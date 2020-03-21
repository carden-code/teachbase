class Railway
  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = {}
    @wagons = []
    @stations = {}
  end

  def menu_items
    messages = ['Выберите действие, введя номер из списка: ',
                ' 1 - Создать станцию.',
                ' 2 - Создать пассажирский поезд.',
                ' 3 - Создать грузовой поезда.',
                ' 4 - Создать пассажирский вагон.',
                ' 5 - Создать грузовой вагон.',
                #' 3 - Создать вагон.',
                #' 4 - Посмотреть список вагонов.',
                #' 5 - Прицепить к поезду вагон из пула вагонов.',
                #' 6 - Отцепить вагон от поезда в пул вагонов.',
                #' 7 - Поместить поезд на станцию.',
                #' 8 - Посмотреть список станций.',
                #' 9 - Посмотреть список поездов на станции.',
                #' 10 - Создать маршрут.',
                #' 11 - Добавитъ станцию в маршрут.',
                #' 12 - Удалитъ станцию в маршруте.',
                #' 13 - Удалить маршрут.',
                #' 14 - Назначать маршрут поезду.',
                #' 15 - Переместить поезд по маршруту вперед.',
                #' 16 - Переместить поезд по маршруту назад.',
                #' 17 - Посмотреть список созданных маршрутов.',
                BORDERLINE,
                ' 0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end

  def data_input(message)
    args = []
    message.each { |mess| print mess }
    args << gets.chomp
  end

  def create_station
    message = 'Введите название станции:'
    name = data_input(message)
    @stations[name.to_sym] = Station.new(name)
  end

  def create_train_pass
    puts 'Введите номер поезда:'
    number = gets.chomp
    @trains[number.to_sym] = PassengerTrain.new(number)
  end

  def create_train_cargo
    puts 'Введите номер поезда:'
    number = gets.chomp
    @trains[number.to_sym] = CargoTrain.new(number)
  end

  def create_wagon_pass
    puts "#{@wagons << PassengerWagon.new} - Пассажирский вагон создан."
  end

  def create_wagon_cargo
    puts "#{@wagons << CargoWagon.new} - Грузовой вагон создан."
  end

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
    end
  end
end
