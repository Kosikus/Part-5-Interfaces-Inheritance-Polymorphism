# вагон знает к какому поезду он прицеплен
# Получается, поезд знает какие вагоны к нему прицеплены
# и сами вагоны знают к какому поезду они прицеплены
# т.е. имеется зависимость поезд -> вагон и вагон -> поезд

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

  # освобождение вагона
  def detach
    self.attached_train = nil
  end

  private
  attr_writer :attached_train
end
