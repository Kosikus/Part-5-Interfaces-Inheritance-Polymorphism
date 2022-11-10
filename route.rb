# Курс: "Основы Ruby [Полная програмаа - 2022]"
# Задание: "Основы ООП в Ruby"
# Класс "Route"
# Студент: Константин Голуб (Kos)

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
  def delete_station(station)
    if self.stations.include?(station) &&
       station != self.departure_station &&
       station != self.arrival_station
      self.stations.delete(station)
    end
  end

  # Вывод всех станций от начальной до конечной в порядке следования по маршруту
  def stations_list
    self.stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def to_s
    # Короткое обозначение маршрута вида
    # "cтанция отправления -> станция назначения"
    "\"#{self.departure_station.name}\" -> \"#{self.arrival_station.name}\""
  end
end
