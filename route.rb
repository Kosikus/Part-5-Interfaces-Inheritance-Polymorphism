class Route
  attr_reader :departure_station, :arrival_station, :stations

  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @stations = [departure_station, arrival_station]
  end

  # Добавление промежуточной станции
  # Упрощениe:
  # Новая промежуточная станция добавляется в конец (перед станцией прибытия),
  # без предоставления выбора пользователю между какими станциями добавить новую
  def add_station(station)
    self.stations.insert(-2, station) unless self.stations.include?(station)
  end

  # Удаление промежуточной станции (аргумент - объект)
  # Станция не должна быть начальной или конечной
  # (ВОПРОС - что будет с поездом, если удаляемая станция совпадает с текущей?
  # тогда смещать поезд на одну станцию вперёд или назад?)
  def delete_station(station)
    if self.stations.include?(station) &&
       station != self.departure_station &&
       station != self.arrival_station
      self.stations.delete(station)
    end
  end

  # Вывод всех станций от начальной до конечной в порядке следования по маршруту
  def stations_list
    self.stations.map.with_index(1) { |station, index| "#{index}. #{station.name}" }.join("\n")
  end

  # массив промежуточных станций
  def intermediate_stations
    self.stations.slice(1..-2)
  end

  # текстовой нумерованный список (начиная с 2-ки), всех промежуточных станций маршрута
  def intermediate_stations_list
    self.intermediate_stations.
         map.with_index(2) { |station, index| "  #{index}. \"#{station.name}\"" }.
         join("\n")
  end

  # Короткое обозначение маршрута вида
  # "cтанция отправления -> станция назначения"
  def to_s
    "\"#{self.departure_station.name}\" -> \"#{self.arrival_station.name}\""
  end
end
