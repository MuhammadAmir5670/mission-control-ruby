# frozen_string_literal: true

# TODO: add documentation for class
class Rocket
  def initialize(distance:, burn_rate:, average_speed:)
    @distance = distance
    @burn_rate = burn_rate
    @average_speed = average_speed
    @distance_traveled = 0
  end
end
