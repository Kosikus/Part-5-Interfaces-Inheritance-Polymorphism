# Курс: "Основы Ruby [Полная программа - 2022]"
# Задание: "Интерфейсы, наследование и полиморфизм"
# Студент: Константин Голуб (Kos)

require_relative "station"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"
require_relative "route"

stations = []
trains = []
routes = []
wagons = []

# посевные данные из "seed.rb"
# require_relative "seed"
# stations = Seed.stations
# wagons = Seed.wagons
# routes = Seed.routes(stations)
# trains = Seed.trains(wagons, routes) # скорости всех поездов - ноль

loop do
  puts
  puts "*******************************************************************************"
  puts "Выберите действие, введя соответствующую цифру"
  puts "1 - Создать новую станцию, поезд, вагон или маршрут"
  puts "2 - Выполнить операцию с существующими станцией, поездом, вагоном или маршрутом"
  puts "3 - Вывести информацию о станции, поезде, вагоне или маршруте"
  puts "0 - Выйти из меню (завершить программу)"

  action_choice = gets.to_i
  break if action_choice.zero?

  action_name = {
                  1 => 'создание',
                  2 => 'выполнение операции с существующими объектом',
                  3 => 'вывод информации'
                }

  puts
  puts "Выберите с каким типом объекта вы хотите выполнить действие \"#{action_name[action_choice]}\""
  puts "1 - Со станцией (станциями)"
  puts "2 - С поездом (поездами)"
  puts "3 - С вагоном (вагонами)"
  puts "4 - С маршрутом (маршрутами)"
  puts "0 - Выйти из меню (завершить программу)"

  object_type_choice = gets.to_i # выбор варианта - объекта для действия
  break if object_type_choice.zero?

  case [action_choice, object_type_choice] # селектор [действие, объект для действия]
  when [1, 1] # [создать, станция]
    puts
    puts "Создание новой станции"
    puts 'Введите имя станции:'

    new_station_name = gets.chomp

    # массив всех имён станций
    all_station_names = stations.map { |station| station.name }

    # добавление станции, если станции с таким именем нет
    if !all_station_names.include?(new_station_name)
      stations << Station.new(new_station_name)
      puts "Cтанция \"#{new_station_name}\" успешно создана."
    else
      puts "Ошибка! Новая станция не создана!"
      puts "Станция с именем \"#{new_station_name}\" уже существует."
    end
  when [1, 2] # [создать, поезд]
    puts
    puts "Создание нового поезда"
    puts "Выберите тип нового поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"

    train_type_choice = gets.to_i

    unless [1, 2].include?(train_type_choice)
      puts "Ошибка ввода! \"#{train_type_choice}\" - нет такого варианта выбора"
      next
    end

    puts "Введите номер нового поезда:"
    new_train_number = gets.chomp

    all_train_numbers = trains.map { |train| train.number }

    if all_train_numbers.include?(new_train_number)
      puts "Ошибка! Новый поезд не создан!"
      puts "Поезд с номером  \"#{new_train_number}\" уже существует."
      next
    end

    case train_type_choice
    when 1 # создать пассажирский поезд
      trains << PassengerTrain.new(new_train_number)
    when 2 # создать грузовой поезд
      trains << CargoTrain.new(new_train_number)
    end

    puts "#{trains.last.type} поезд под номером #{trains.last.number} успешно создан."
  when [1, 3] # создать вагон (пассажирский или грузовой)
    puts
    puts "Создание нового вагона"
    puts "Выберите тип нового вагона:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"

    wagon_type_choice = gets.to_i

    unless [1, 2].include?(wagon_type_choice)
      puts "Ошибка ввода! \"#{wagon_type_choice}\" - нет такого варианта выбора"
      next
    end

    puts "Введите номер нового вагона:"
    new_wagon_number = gets.chomp

    all_wagon_numbers = wagons.map { |wagon| wagon.number }

    if all_wagon_numbers.include?(new_wagon_number)
      puts "Ошибка! Новый вагон не создан!"
      puts "Вагон с номером  \"#{new_wagon_number}\" уже существует."
      next
    end

    case wagon_type_choice
    when 1 # создать пассажирский вагон
      wagons << PassengerWagon.new(new_wagon_number)
    when 2 # создать грузовой вагон
      wagons << CargoWagon.new(new_wagon_number)
    end

    puts "#{wagons.last.type} вагон под номером #{wagons.last.number} успешно создан."
  when [1, 4] # создать маршрут
    puts "Создание нового маршрута"
    # строка - нумерованный (с единицы) список всех станций
    all_stations_list = stations.map.
                                 with_index(1) { |station, index| "#{index}. #{station.name}" }.
                                 join("\n")

    puts "Выберите станцию отправления, введя соответствующую цифру:"
    puts all_stations_list
    departure_station_choice = gets.to_i

    unless departure_station_choice.between?(1, all_stations_list.size)
      puts "Ошибка ввода! \"#{departure_station_choice}\" - нет такого варианта выбора"
      next
    end

    departure_station = stations[departure_station_choice - 1]

    puts "Выберите станцию прибытия, введя соответствующую цифру:"
    puts all_stations_list
    arrival_station_choice = gets.to_i

    unless arrival_station_choice.between?(1, all_stations_list.size)
      puts "Ошибка ввода! \"#{arrival_station_choice}\" - нет такого варианта выбора"
      next
    end

    arrival_station = stations[arrival_station_choice - 1]

    if departure_station_choice == arrival_station_choice
      puts "Ошибка! Станция прибытия не может быть станцией отправления"
      puts "Новый маршрут не создан"
      next
    end

    routes << Route.new(departure_station, arrival_station)

    puts "Новый маршрут \"#{departure_station.name}\" -> \"#{arrival_station.name}\" успешно создан."
  when [2, 1] # операция со станцией
    puts
    puts "Отсутствуют действия со станциями"

    next
  when [2, 2] # операция с поездом
    puts
    puts "Действие с поездом:"

    # текстово нумерованный список всех поездов
    trains_list = trains.map.
                         with_index(1) { |train, index| "#{index}. #{train.number} (#{train.type})" }.
                         join("\n")

    puts "Выберите поезд, с которым вы хотите выполнить операцию, введя соответствующую цифру:"
    puts trains_list

    train_choice = gets.to_i

    unless train_choice.between?(1, trains.size)
      puts "Ошибка ввода! \"#{train_choice}\" - нет такого варианта выбора"
      next
    end

    train = trains[train_choice - 1]

    puts "Выберите действие, которые вы хотите выполнить с поездом #{train.number} (#{train.type}), " +
         "введя соответствующую цифру"
    puts "1 - Установить новый маршрут"
    puts "2 - Переместить поезд на одному станцию вперед"
    puts "3 - Переместить поезд на одному станцию назад"
    puts "4 - Прицепить вагон к поезду"
    puts "5 - Отцепить вагон от поезда"

    train_action_choice = gets.to_i

    unless train_action_choice.between?(1, 5)
      puts "Ошибка ввода! \"#{train_action_choice}\ - нет такого варианта выбора"
      next
    end

    case train_action_choice
    when 1 # назначение нового маршрута
      puts "Выберите маршрут, который вы хотите назначить поезду #{train.number} (#{train.type})"

      # текствовой нумерованный список всех созданных маршрутов
      all_routes_list = routes.map.
                               with_index(1) { |route, index| "#{index}. #{route.to_s}" }.
                               join("\n")

      puts all_routes_list

      route_choice = gets.to_i

      unless route_choice.between?(1, routes.size)
        puts "Ошибка ввода! \"#{route_choice}\" - нет такого варианта выбора"
        next
      end

      route = routes[route_choice - 1]

      train.set_route(route)

      puts "Маршрут #{route.to_s} поезду #{train.number} (#{train.type}) успешно назначен"
    when 2 # переместить поезд на одну станцию вперед
      puts
      puts "Перемещение поезда на одну станцию вперёд"

      if train.route.nil?
        puts "Внимание! Поезду не назначен ни один маршрут. Перемещения по маршруту невозможны"
        next
      end

      if train.current_station == train.route.arrival_station
        puts "Поезд находится на станции прибытия \"#{train.route.arrival_station.name}\" маршрута #{train.route.to_s}"
        puts "Перемещение на станцию вперёд невозможно"
      else
        train.go_to_next_station

        puts "#{train.number} (#{train.type}) перемещен на одну станцию вперёд: " +
             "со станции \"#{train.previous_station.name}\" " +
             "на станцию \"#{train.current_station.name}\""
      end
    when 3 # переместить на одну станцию назад
      puts
      puts "Перемещение поезда на одну станцию назад"

      if train.route.nil?
        puts "Внимание! Поезду не назначен ни один маршрут. Перемещения по маршруту невозможны"
        next
      end

      if train.current_station == train.route.departure_station
        puts "Поезд находится на станции отправления \"#{train.route.departure_station.name}\" маршрута #{train.route.to_s}"
        puts "Перемещение на станцию назад невозможно"
      else
        train.go_to_previous_station

        puts "#{train.number} (#{train.type}) перемещен на одну станцию назад: " +
             "со станции \"#{train.next_station.name}\" " +
             "на станцию \"#{train.current_station.name}\""
      end
    when 4 # прицепить вагон к поезду
      # Прицепить можно только свободный вагон или
      # вагон, прицепленный к поезду, который не двигается
      # и только к поезду который также не двигается
      puts
      puts "Добавление вагона к поезду #{train.number} (#{train.type}):"

      unless train.speed.zero?
        puts "Внимание! Поезд в движении. Невозможна прицепка вагонов"
        next
      end

      # Вопрос: скорость поезда проверять тут или в методе?

      # выбор только тех вагонов, которые соответсвуют типу поезда, помимо того
      # свободны или прицеплены к поезду который не двигается
      avaible_wagons = wagons.select { |wagon| train.type == wagon.type &&
                                       (wagon.free? or wagon.attached_train.speed.zero?) }

      # текстовой список доступных к прицепке вагонов
      avaible_wagons_list = avaible_wagons.map.with_index(1) { |wagon, index| "#{index}. #{wagon.number} (#{wagon.type})" }

      puts "Выберите вагон, который вы хотите прицепить к поезду #{train.number} (#{train.type})"

      puts avaible_wagons_list

      wagon_choice = gets.to_i

      unless wagon_choice.between?(1, avaible_wagons.size)
        puts "Ошибка ввода! \"#{wagon_choice}\" - нет такого варианта выбора"
        next
      end

      wagon = avaible_wagons[wagon_choice - 1]

      train.add_wagon(wagon)

      puts "Обновлённый список вагонов для поезда #{train.number} (#{train.type})"
      puts train.wagon_list
    when 5 # отцепить вагон от поезда
      # Отцепить можно только вагон, прицепленный к выбранному поезду
      # и только если поезд не двигается
      puts
      puts "Отцепка вагона от поезда #{train.number} (#{train.type}):"

      if train.wagons.empty?
        puts "Внимание! К поезду не прицеплен ни один вагон. Невозможна отцепка вагонов"
        next
      end

      puts "Выберите вагон, который вы хотите отцепить от поезда #{train.number} (#{train.type})"
      puts train.wagon_list

      wagon_choice = gets.to_i

      unless (1..train.wagons.size).include?(wagon_choice)
        puts "Ошибка ввода! \"#{wagon_choice}\" - нет такого варианта выбора"
        next
      end

      wagon = train.wagons[wagon_choice - 1]

      train.remove_wagon(wagon)

      puts "Обновлённый список вагонов для поезда #{train.number} (#{train.type})"
      puts train.wagon_list
    end
  when [2, 3] # операция с вагоном
    puts
    puts "Нет операций с вагоном"
  when [2, 4] # Операция с маршрутом
    puts
    puts "Операция с маршрутом:"

    if routes.empty?
      puts "Ни один маршрут не создан!"
      next
    end

    # Текстовой нумерованный список всех созданных маршутов
    routes_list = routes.map.
                         with_index(1) { |route, index| "#{index}. #{route.to_s}" }.
                         join("\n")

    puts "Выберите маршрут, с которым вы хотите выполнить операцию"
    puts "(удаление/добавление новой станции)"
    puts routes_list

    route_choice = gets.to_i

    unless route_choice.between?(1, routes.size)
      puts "Ошибка ввода! \"#{route_choice}\" - нет такого варианта выбора"
      next
    end

    route = routes[route_choice - 1]

    puts "Какую операцию вы хотите выполнить с маршрутом #{route.to_s}"
    puts "1 - Добавление станции к маршруту"
    puts "2 - Удаление станции из маршрута"

    action_choice = gets.to_i

    unless action_choice.between?(1, 2)
      puts "Ошибка ввода! \"#{action_choice}\" - нет такого варианта выбора"
      next
    end

    case action_choice
    when 1 # Добавление промежуточной станции к маршруту
      puts "Добавление промежуточной станции к маршруту (в конец маршрута перед станцией прибытия):"

      # станции доступные к добавлению (вне текущего маршрута)
      avaible_stations = stations.difference(route.stations)

      if avaible_stations.empty?
        puts "Нет доступных станций для добавления в маршрут!"
        next
      end

      # текстовой список всех доступных станций
      avaible_stations_list =
        avaible_stations.
        map.with_index(1) { |station, index| "#{index}. #{station.name}" }.
        join("\n")

      puts "Выберите станцию для добавления в маршрут"
      puts avaible_stations_list

      station_choice = gets.to_i

      unless station_choice.between?(1, avaible_stations.size)
        puts "Ошибка ввода! \"#{station_choice}\" - нет такого варианта выбора"
        next
      end

      station = avaible_stations[station_choice - 1]

      route.add_station(station)

      puts "Станция \"#{station.name}\" успешно добавлена к маршруту"
      puts "Обновленный маршрут #{route.to_s} выглядит так:"
      puts route.stations_list
    when 2 # Удаление станции из маршрута
      puts "Удаление станции из маршрута"
      puts "Выберите номер станции для удаления"
      puts "(Далее идущие станции сместятся назад на одну позицию)"

      avaible_stations = route.stations.slice(1..-2)

      if avaible_stations.empty?
        puts "Нет доступных станций для удаления!"
        next
      end

      # Станции для удаления (первую и последнюю станции исключаем)
      avaible_stations_list =
        avaible_stations.
        map.with_index(1) { |station, index| "#{index}. #{station.name}" }.
        join("\n")

      puts "#{route.departure_station.name} - станция отправления (недоступна для удаления)"
      puts avaible_stations_list
      puts "#{route.arrival_station.name} - станция прибытия (недоступна для удаления)"

      station_choice = gets.to_i

      unless station_choice.between?(1..avaible_stations.size)
        puts "Ошибка ввода! \"#{station_choice}\" - нет такого варианта выбора"
        next
      end

      station = stations[station_choice]
      route.delete_station(station)

      puts "Станция \"#{station.name}\" удалена из маршрута"
      puts "Обновленный маршрут #{route.to_s} выглядит так:"
      puts route.stations_list
    end
  when [3, 1] # Вывод информации о всех станциях
    puts
    puts "Информация о станциях:"

    if stations.empty?
      puts "Не созданных станций!"
      next
    end

    stations.each.with_index(1) do |station, index|
      puts "  #{index}. \"#{station.name}\""
      puts "  Поезда на станции:"

      if station.trains.empty?
        puts "    Нет поездов на станции"
      else
        station.trains.each { |train| puts "    #{train.number} (#{train.type}), кол-во вагонов #{train.wagons.size}" }
      end

      puts
    end
  when [3, 2] # Вывод информации о всех поездах
    puts
    puts "Вывод информации о поездах"

    if trains.empty?
      puts "Созданные поезда отсутствуют!"
      next
    end

    trains.each do |train|
      puts " -#{train.number}, тип: #{train.type}, кол-во вагонов: #{train.wagons.size}"

      if train.route.nil?
        puts "  Без маршрута"
      else
        puts "  Маршрут #{train.route.to_s}"
        puts "  Находится на станции \"#{train.current_station.name}\""
      end

      if train.wagons.empty?
        puts "  Нет прицепленных вагонов"
      else
        puts "  Прицепленные вагоны:"
        train.wagons.each { |wagon| puts "    #{wagon.number} (#{wagon.type})" }
      end

      puts
    end
  when [3, 3] # Информация о вагонах
    puts
    puts "Вывод информации о всех вагонах"

    if wagons.empty?
      puts "Созданные вагоны отсутствуют"
      next
    end

    # вывод информации о всех вагонах "номер, тип, к какому поезду прицеплены"
    wagons.each do |wagon|
      attached_train_text =
        if wagon.attached_train
          "прицеплен поезду #{wagon.attached_train.number}"
        else
          "не прицеплен"
        end

      puts " -#{wagon.number}, тип #{wagon.type}, #{attached_train_text}"
    end
  when [3, 4] # Информация о всех маршрутах
    puts
    puts "Информация о всех маршрутах:"

    if routes.empty?
      puts "Созданные маршруты отсутствуют"
      next
    end

    routes.each do |route|
      puts "  #{route.to_s}"
      puts "  Станции маршрута:"

      puts "  1. \"#{route.departure_station.name}\" - станция отправления"
      puts route.intermediate_stations_list unless route.intermediate_stations.empty?
      puts "  #{route.stations.size}. \"#{route.arrival_station.name}\" - станция прибытия"
      puts
    end
  end
end

puts "Программа завершена"
