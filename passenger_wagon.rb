class PassengerWagon < Wagon
  attr_reader :type

	def initialize(name)
		super

		@type = :passenger
	end
end
