# Курс: "Основы Ruby [Полная программа - 2022]"
# Задание: "Основы ООП в Ruby"
# Класс "Train"
# Студент: Константин Голуб (Kos)

# "Может набирать скорость" - сделал просто через метод-сеттер "speed"

###
# Внесения сделаны с основного компа
# Изменения сделаны с ноута под Linux
##

class Train
  attr_reader :number, :current_station, :route, :wagons
  attr_accessor :speed

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = nil
    @current_station = nil
  end

  # Остановка поезда
  def stop
    self.speed = 0
  end

  # Добавление вагона (добавляется в хвост поезда)
  def add_wagon(wagon)
    # использую инстанс-переменную не в initialize (нормально ли?)
    if self.speed.zero?
      @wagons << wagon
      wagon.attache_to_train(self)
    end
  end

  # Удаление вагона
  def remove_wagon(wagon)
    # использую инстанс-переменную не в initialize (нормально ли?)
    @wagons.delete(wagon) if self.speed.zero?

    wagon.detach # сделать ваон свободным
  end

  # Назначение маршрута
  def set_route(route)
    # удаление поезда с текущей станции (до назначения нового маршрута)
    self.current_station.depart_station(self)

    self.route = route # приватный?
    self.current_station = self.route.departure_station # приватный

    # появление на начальной станции нового маршрута (после назначения нового маршрута)
    self.current_station.accept_train(self) # добавление поезда на начальную станцию маршрута
  end

  # Переход на следующую станцию
  # Если находимся на конечной, то на ней и остаёмся
  def go_to_next_station
    self.current_station = self.next_station
  end

  # Переход на предыдущую станцию
  # Если находимся на начальной станции, то на ней и остаёмся
  def go_to_previous_station
    self.current_station = self.previous_station
  end

  # Определение следующей станции
  def next_station
    if self.current_station != self.route.arrival_station
      self.route.stations[self.route.stations.index(self.current_station) + 1]
    else
      self.current_station
    end
  end

  # Определение предыдущей станции
  def previous_station
    if self.current_station != self.route.departure_station
      self.route.stations[self.route.stations.index(self.current_station) - 1]
    else
      self.current_station
    end
  end

  def wagon_list
    if self.wagons.empty?
      "Нет прицепленных вагонов"
    else
      self.wagons.map.with_index(1) { |wagon, index| "#{index}. #{wagon.number} #{wagon.type}" }
    end
  end

  private

  attr_writer :route, :current_station
end
