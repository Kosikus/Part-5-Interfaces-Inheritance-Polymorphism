# Курс: "Основы Ruby [Полная програмаа - 2022]"
# Задание: "Основы ООП в Ruby"
# Класс "Station"
# Студент: Константин Голуб (Kos)

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name # имя станции
    @trains = [] # массив всех поездов (объектов) на станции на текущий момент
  end

  # Приём поезда на станцию
  # добавление (прибытие) нового поезда на станцию, если такого поезда ещё нет на станции
  def accept_train(train)
    # использую инстанс-переменную не в initialize (нормально ли?)
    @trains << train unless self.trains.include?(train)
  end

  # Отправление поезда
  def depart_train(train)
    # удаление (отпрвление) поезда со станции, если такой поезд есть на станции
    @trains.delete(train) if self.trains.include?(train)
  end

  # Массив всех поездов на станции по типу ("passenger"/"cargo")
  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  # Количество поездов на станции по типу ("passenger"/"cargo")
  def trains_amount_by_type(type)
    trains.count { |train| train.type == type }
  end
end
