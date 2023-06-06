# frozen_string_literal: true

# TODO: add documentation for class
class Mission
  def initialize(travel_distance, payload_capacity, fuel_capacity, burn_rate, average_speed)
    @travel_distance = travel_distance
    @payload_capacity = payload_capacity
    @fuel_capacity = fuel_capacity
    @burn_rate = burn_rate
    @average_speed = average_speed
    @random_seed = 12
    @summary = {}
  end
end
