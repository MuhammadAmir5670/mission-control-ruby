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

  def print_plan
    puts 'Mission plan:'
    puts "  Travel distance: #{@travel_distance} km"
    puts "  Payload capacity: #{@payload_capacity} kg"
    puts "  Fuel capacity: #{@fuel_capacity} liters"
    puts "  Burn rate: #{burn_rate} liters/min"
    puts "  Average speed: #{@average_speed} km/h"
    puts "  Random seed: #{@random_seed}"
  end

  def fetch_mission_name
    print 'What is the name of this mission? '
    @mission_name = gets.chomp
  end
end
