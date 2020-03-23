class Railway
  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = []
    @wagons = []
    @stations = []
  end

  #
  def menu_items
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Создать станцию.',
                ' 2 - Создать пассажирский поезд.',
                ' 3 - Создать грузовой поезд.',
                ' 4 - Создать пассажирский вагон.',
                ' 5 - Создать грузовой вагон.',
                ' 6 - Посмотреть список вагонов.',
                ' 7 - attach_wagon.',
                BORDERLINE,
                '  0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end

  #

  def data_input(message)
    @args = []
    message.each { |mess| print mess }
    @args << gets.chomp
  end

  #
  def dublicate_name?(arr, name)
    arr.each { |elem| return true if elem.name == name.to_s }
    false
  end

  #
  def create_station
    message = ['Введите название станции:']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@stations, name)

    @stations << Station.new(name)
  end

  #
  def dublicate_number?(arr, number)
    arr.each { |elem| return true if elem.number == number.to_s }
    false
  end

  #
  def create_train_pass
    message = ['Введите номер поезда:']
    number = data_input(message).first

    return unless number != '' && !dublicate_number?(@trains, number)

    @trains << PassengerTrain.new(number)
  end

  #
  def create_train_cargo
    message = ['Введите номер поезда:']
    number = data_input(message).first

    return unless number != '' && !dublicate_number?(@trains, number)

    @trains << CargoTrain.new(number)
  end

  #
  def create_wagon_pass
    @wagons << PassengerWagon.new
  end

  #
  def create_wagon_cargo
    @wagons << CargoWagon.new
  end

  #
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
  def selected_train
    message = @trains
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    index = data_input(message).first.to_i - 1
    puts "\n\nindex: #{index}"
    selected_train = @trains[index]
    puts "Selected train: #{selected_train}"
  end

  def selected_wagon
    message = @wagons
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
    index = data_input(message).first.to_i - 1
    puts "\n\nindex: #{index}"
    selected_wagon = @wagons[index]
    puts "Selected wagon: #{selected_wagon}"
  end

  def attach_wagon
    selected_train
    selected_wagon
    selected_train.attach_wagon(selected_wagon)
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
    when '7'
      attach_wagon
    else
      puts 'Повторите ввод!'
    end
  end
end
