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
    # использую инстанс-переменную "@wagons" не в initialize - нормально ли?
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
    # если поезд был на какой-то станции (был назначен маршрут), то с этой станции поезд нужно удалить
    self.current_station.depart_train(self) unless self.current_station.nil?

    self.route = route # приватный?

    # после назначения маршрута, текущей станцией должна стать станциея отправления
    self.current_station = self.route.departure_station # приватный

    # приём поезда начальной станцией нового маршрута
    self.current_station.accept_train(self)
  end

  # Переход на следующую станцию
  def go_to_next_station
    # удаление поезда с текущей станции
    self.current_station.depart_train(self)

    # меняем текущую на следующую
    self.current_station = self.next_station

    # приём поезда начальной станцией нового маршрута
    self.current_station.accept_train(self)
  end

  # Переход на предыдущую станцию
  def go_to_previous_station
    # удаление поезда с текущей станции
    self.current_station.depart_train(self)

    # меняем текущую на предыдущую
    self.current_station = self.previous_station

    # приём поезда начальной станцией нового маршрута
    self.current_station.accept_train(self)
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
  # Эти методы-сеттеры изменяют значения инстанс-переменных,
  #  т.е. изменяют состояние объекта, поэтому прямой доступ к ним извне закрыт.
  # Дополнительно к этому изменение маршрута @route вызывает изменение значения
  # инстанс-переменной @current_station, и инстанс переменной @trains у объекта станции-оправления
  # и объекта-станции, откуда поезда прибыл на текущую. Короче, одно изменение влечёт
  # множество других, что нужно учитывать, а прямое изменение @route это не учтёт.
  attr_writer :route, :current_station
end
