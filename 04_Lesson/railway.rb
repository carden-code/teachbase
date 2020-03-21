class Railway
  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = []
    @wagons = []
    @stations = []
  end

  def menu_items
    messages = ['Выберите действие, введя номер из списка: ',
                ' 1 - Создать станцию.',
                ' 2 - Создать пассажирский поезд.',
                ' 3 - Создать грузовой поезда.',
                ' 4 - Создать пассажирский вагон.',
                ' 5 - Создать грузовой вагон.',
                ' 6 - Посмотреть список вагонов.',
                ' 7 - Прицепить к поезду вагон из пула вагонов.',
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
    @stations << Station.new(name)
  end

  def create_train_pass
    message = 'Введите номер поезда:'
    number = data_input(message)
    @trains << PassengerTrain.new(number)
  end

  def create_train_cargo
    message = 'Введите номер поезда:'
    number = data_input(message)
    @trains << CargoTrain.new(number)
  end

  def create_wagon_pass
    @wagons << PassengerWagon.new
  end

  def create_wagon_cargo
    @wagons << CargoWagon.new
  end

  def list_wagons
    puts @wagons
  end

  def attach_wagon
    message = @trains
    message.each_with_index { |mess, index| puts index + 1, mess }

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
    when '6'
      list_wagons
    end
  end
end
