# frozen_string_literal: true

# TODO: add documentation for class
class Mission
  attr_reader :summary

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

  def proceed?
    prompt('Would you like to proceed?')
  end

  def start
    rocket = Rocket.prepare_for_launch(
      distance: 160,
      burn_rate: 168_240,
      average_speed: 1500
    )

    if rocket.launch?
      rocket.launch do |status|
        display_mission_status(status)
      end
    end

    @summary = rocket.summary
  end

  private

  def display_mission_status(**status)
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{status[:current_fuel_burn_rate]} liters/min"
    puts "  Current speed: #{status[:current_speed]} km/h"
    puts "  Current distance traveled: #{status[:distance_traveled]} km"
    puts "  Elapsed time: #{format_time(status[:elapsed_time])}"
    puts "  Time to destination: #{format_time(status[:time_to_destination])}"
  end

  def format_time(time)
    hours = time / 3600
    minutes = (time % 3600) / 60
    seconds = time % 60

    format('%02d:%02d:%02d', hours, minutes, seconds)
  end
end
