class Seed
  def self.stations
    [
      Station.new('Ивановка'),
      Station.new('Петровка'),
      Station.new('Майдановка'),
      Station.new('Селятино'),
      Station.new('Балашиха'),
      Station.new('Маяковская'),
      Station.new('Васюки'),
    ]
  end

  def self.wagons
    [
      PassengerWagon.new("634PF"),
      PassengerWagon.new("932PE"),
      PassengerWagon.new("116PM"),
      PassengerWagon.new("247PQ"),
      PassengerWagon.new("658PW"),
      PassengerWagon.new("902PC"),

      CargoWagon.new("158СA"),
      CargoWagon.new("3795СS"),
      CargoWagon.new("228СR"),
      CargoWagon.new("109СQ"),
      CargoWagon.new("378СW"),
      CargoWagon.new("270СS"),
      CargoWagon.new("503СR"),
      CargoWagon.new("147СN"),
      CargoWagon.new("309СD"),
    ]
  end

  def self.trains(all_wagons)
    wagons = all_wagons
    trains = []

    puts PassengerTrain.new('PT99').methods

    p1 = PassengerTrain.new('PT24'); p1.add_wagon(wagons[0]); p1.add_wagon(wagons[1])
    p2 = PassengerTrain.new('PT17'); p2.add_wagon(wagons[2]); p2.add_wagon(wagons[3])

    c1 = CargoTrain.new('CT63'); c1.add_wagon(wagons[6]); c1.add_wagon(wagons[7])
    c2 = CargoTrain.new('CT49'); c2.add_wagon(wagons[8])

    [
      p1,
      p2,

      c1,
      c2
    ]
  end
end
