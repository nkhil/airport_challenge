require_relative './plane'
require_relative './weather'

class Airport
  attr_reader :planes_in_airport
  attr_reader :capacity

  DEFAULT_CAPACITY = 10

  def initialize(capacity = DEFAULT_CAPACITY)
    @plane = Plane.new
    @weather = Weather.new
    @planes_in_airport = []
    @capacity = capacity
  end

  def land(plane) 
    throw_land_exception(plane)
    raise Exception.new(m_landing_denied) if stormy || capacity_reached?

    plane.landed = true
    @planes_in_airport << plane
  end

  def take_off(plane)
    raise Exception.new(m_plane_not_in_airport) unless plane_in_airport?(plane)
    raise Exception.new(m_take_off_denied) if stormy

    @planes_in_airport.delete(plane)
  end

  def capacity_reached?
    @planes_in_airport.length >= @capacity
  end

  def plane_in_airport?(plane)
    planes_in_airport.include?(plane)
  end

  def stormy
    @weather.stormy?
  end

  private

  def throw_land_exception(plane)
    raise Exception.new(m_plane_already_landed) if plane_in_airport?(plane)
    raise Exception.new(m_plane_in_another_airport) if plane.landed == true
  end

  def m_plane_not_in_airport
    "This plane doesn't exist in the airport"
  end

  def m_plane_already_landed
    "This plane has already landed"
  end

  def m_plane_in_another_airport
    "This plane is currently landed in another airport"
  end

  def m_landing_denied
    "No landings permitted"
  end

  def m_take_off_denied
    "No take offs permitted"
  end

end
