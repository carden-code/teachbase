require_relative 'train'
require_relative 'route'
require_relative 'wagon'
require_relative 'station'
require_relative 'railway'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
class Railway
  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = []
    @wagons = []
    @stations = []
  end

  def menu
    p 'Введите: 1, если вы хотите создать станцию, поезд, вагон или маршрут.'
    p 'Введите: 2, если вы хотите произвести операции над созданными объектами.'
    p 'Введите: 3, если вы хотите посмотреть информацию об объектах.'
    p 'Введите: 0, если хотите завершить программу.'
    input = gets.chomp
    if input == '1'
      p 'Введите: 1, если хотите создать станцию.'
      p 'Введите: 2, если хотите создать поезд.'
      p 'Введите: 3, если хотите создать вагон.'
      p 'Введите: 4, если хотите создать маршрут.'
      input = gets.chomp
      if input == '1'
        p 'Введите название станции:'
        p "#{@stations << Station.new(gets.chomp)} - Станция успешно создана."
      end
      if input == '2'
        p 'Введите: 1, если хотите создать пассажирский поезд.'
        p 'Введите: 2, если хотите создать грузовой поезд.'
        input = gets.chomp
        if input == '1'
          p 'Введите номер пассажирского поезда:'
          @trains << PassengerTrain.new(gets.chomp)
        end
        if input == '2'
          p 'Введите номер грузового поезда:'
          @trains << CargoTrain.new(gets.chomp)
        end
      end
      if input == '3'
        p 'Введите: 1, если хотите создать пассажирский вагон.'
        p 'Введите: 2, если хотите создать грузовой вагон.'
        input = gets.chomp
        if input == '1'
          p "#{@wagons << PassengerWagon.new} - Пассажирский вагон создан."
        end
        if input == '2'
          p "#{@wagons << CargoWagon.new} - Грузовой вагон создан."
        end
      end
      if input == '4'
        p 'Введите: 1, если хотите создать начальный маршрут.'
        p 'Введите: 2, если хотите добавить промежуточные станции в маршрут.'
        input = gets.chomp
        if input == '1'
          if @stations.size >= 2
            p @routes << Route.new(@stations.first, @stations.last)
          else
            p 'Создайте пожалуйста 2 станции начальную и конечную станцию.'
          end
        end
        if input == '2'
          if !@routes.nil?
            p 'Введите промежуточную станцию:'
            @routes.first.midway(gets.chomp)
          end
        end
      end
    end
    if input == '2'
      p 'Введите: 1, если хотите назначить маршрут поезду.'
      p 'Введите: 2, если хотите добавить вагоны к поезду.'
      p 'Введите: 3, если хотите отцепить вагоны от поезда.'
      p 'Введите: 4, если хотите перемещать по маршруту поезд вперед и назад.'
      input = gets.chomp
      if input == '1'
        p "#{@trains.first.route(@routes.first)} - Маршрут назначен"
      end
      if input == '2'
        if @trains.first.type == ('pass' || 'cargo')
          @trains.first.attach_wagon(@wagons.first)
        end
      if input == '3'
        @trains.first.detach_wagon
      end
      if input == '4'
        p 'Введите: 1, если хотите переместить поезд на станцию вперед.'
        p 'Введите: 2, если хотите переместить поезд на станцию назад.'
        input = gets.chomp
        if input == '1'
          @trains.first.move_forwards
        end
        if input == '2'
          @trains.first.move_backwards
        end
      end
      end
    end
  end
end
