# frozen_string_literal: true

require_relative './rocket'
require_relative './mixins/prompt'

# Mission class represents a space mission with customizable parameters.
# It allows you to plan and execute a mission with a rocket.
#
# Usage:
#   mission = Mission.new(
#     travel_distance: 160,
#     payload_capacity: 500_00,
#     fuel_capacity: 151_410_0,
#     burn_rate: 168_233,
#     average_speed: 1500
#   )
#
#   mission.print_plan
#   mission.fetch_mission_name
#   if mission.proceed?
#     mission.start
#     mission.summary # retrieve mission summary after completion
#   end
#
# Attributes:
#   - travel_distance: The distance to be traveled by the rocket (default: 160 km).
#   - payload_capacity: The maximum payload capacity of the rocket (default: 500_00 kg).
#   - fuel_capacity: The fuel capacity of the rocket (default: 151_410_0 liters).
#   - burn_rate: The fuel burn rate of the rocket (default: 168_233 liters/min).
#   - average_speed: The average speed of the rocket (default: 1500 km/h).
#
# Public Methods:
#   - print_plan: Prints the mission plan with the configured parameters.
#   - fetch_mission_name: Asks for user input to set the mission name.
#   - proceed?: Asks for user confirmation to proceed with the mission.
#   - start: Initiates the rocket launch and displays the mission status.
#   - summary: Retrieves the summary of the mission after completion.
#
# Private Methods:
#   - display_mission_status: Displays the current status of the mission.
#   - format_time: Formats the elapsed time into HH:MM:SS format.
#
class Mission
  include Prompt

  attr_reader :summary

  def initialize(
    travel_distance: 160,
    payload_capacity: 500_00,
    fuel_capacity: 151_410_0,
    burn_rate: 168_233,
    average_speed: 1500
  )
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
    puts "  Burn rate: #{@burn_rate} liters/min"
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
      distance: 160, burn_rate: 168_240, average_speed: 1500
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
