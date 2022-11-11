# Посевные данные для теста основной программы main.rb

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

  def self.routes(stations)
    route0 = Route.new(stations[0], stations[4]) # Ивановка - Балашиха

    route1 = Route.new(stations[2], stations[6]) # Майдановка - Васюки
    route1.add_station(stations[0])
    route1.add_station(stations[5])

    route2 = Route.new(stations[1], stations[5]) # Петровка - Маяковская
    route2.add_station(stations[0])
    route2.add_station(stations[2])
    route2.add_station(stations[3])
    route2.add_station(stations[4])
    route2.add_station(stations[6])

    [route0, route1, route2]
  end


  def self.trains(wagons, routes)
    p0 = PassengerTrain.new('PT83')

    p1 = PassengerTrain.new('PT24') # Майдановка - Васюки
    p1.add_wagon(wagons[0])
    p1.add_wagon(wagons[1])
    p1.set_route(routes[1])

    p2 = PassengerTrain.new('PT17')  # Майдановка - Васюки
    p2.add_wagon(wagons[2])
    p2.add_wagon(wagons[3])
    p2.add_wagon(wagons[4])
    p2.add_wagon(wagons[5])
    p2.set_route(routes[1])

    c0 = CargoTrain.new('CT63') # Ивановка - Балашиха
    c0.set_route(routes[0])

    c1 = CargoTrain.new('CT49') # Майдановка - Васюки
    c1.add_wagon(wagons[6])
    c1.set_route(routes[1])

    c2 = CargoTrain.new('CT77') # Петровка - Маяковская
    c2.add_wagon(wagons[7])
    c2.add_wagon(wagons[8])
    c2.set_route(routes[2])

    c3 = CargoTrain.new('CT58') # Ивановка - Балашиха
    c3.add_wagon(wagons[9])
    c3.add_wagon(wagons[10])
    c3.add_wagon(wagons[11])
    c3.add_wagon(wagons[12])
    c3.set_route(routes[0])

    [p0, p1, p2, c0, c1, c2, c3]
  end
end
