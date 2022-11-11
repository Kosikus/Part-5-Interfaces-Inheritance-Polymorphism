class Wagon
  attr_reader :number, :attached_train

  def initialize(number)
  	@number = number
    @attached_train = nil
  end

  # присоеденить к поезду
  def attache_to_train(train)
    self.attached_train = train
  end

  def free?
    self.attached_train.nil?
  end

  # освобождение (отцепка) вагона
  def detach
    self.attached_train = nil
  end

  private
  # метод-сеттер "attached_train" изменяет значение инстанс-переменной,
  #  т.е. изменяет состояние объекта, поэтому прямой доступ к нему извне закрыт
  attr_writer :attached_train
end
