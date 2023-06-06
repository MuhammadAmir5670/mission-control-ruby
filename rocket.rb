# frozen_string_literal: true

require_relative './launch_control'

# Rocket class represents a rocket used for space missions.
#
# Usage:
#   rocket = Rocket.prepare_for_launch(
#     distance: 160,
#     burn_rate: 168_240,
#     average_speed: 1500
#   )
#
#   rocket.launch? && rocket.launch do |status|
#     # Perform actions based on the mission status
#     # For example, display the status to the console
#     puts status
#   end
#
#   rocket.summary # Retrieve the summary of the mission after completion
#
# Attributes:
#   - distance: The total distance the rocket needs to travel.
#   - burn_rate: The fuel burn rate of the rocket in liters per minute.
#   - average_speed: The average speed of the rocket in kilometers per hour.
#
# Public Class Methods:
#   - prepare_for_launch: Creates a new instance of the Rocket class and prepares it for launch.
#
# Public Instance Methods:
#   - launch?: Checks if the rocket is ready for launch.
#   - launch: Initiates the rocket launch and executes the given block of code for each iteration.
#   - summary: Retrieves the summary of the mission after completion.
#
# Private Instance Methods:
#   - explode_iteration: Calculates the iteration at which the rocket will explode, if applicable.
#   - flight_time: Calculates the elapsed flight time of the rocket.
#   - status: Retrieves the current status of the rocket, including elapsed time, distance traveled, etc.
#   - reached_destination?: Checks if the rocket has reached its destination.
#   - current_speed: Calculates the current speed of the rocket in kilometers per minute.
#   - calculate_time_to_destination: Calculates the estimated time remaining to reach the destination.
#   - calculate_distance_traveled: Calculates the distance traveled by the rocket based on the elapsed time.
#   - calculate_total_fuel_burned: Calculates the total amount of fuel burned by the rocket.
#
class Rocket
  attr_reader :distance, :burn_rate,
              :average_speed, :distance_traveled, :elapsed_time

  def initialize(distance, burn_rate, average_speed)
    @launch_control = LaunchControl.new
    @distance = distance
    @burn_rate = burn_rate
    @average_speed = average_speed
    @distance_traveled = 0
    @elapsed_time = 0
  end

  def self.prepare_for_launch(distance:, burn_rate:, average_speed:)
    rocket = new(distance, burn_rate, average_speed)

    rocket.prepare_for_launch

    rocket
  end

  def prepare_for_launch
    @launch_control.prepare_for_launch
  end

  def launch?
    @launch_control.launch?
  end

  def launch
    @elapsed_time = 0
    @distance_traveled = 0
    @flight_time = Time.now

    until reached_destination?
      break puts 'Exploded!' if explode_iteration == elapsed_time

      # Update rocket's position, fuel burn, speed, etc.
      # You can implement the specific logic based on your requirements
      # Increment the elapsed time and distance traveled
      @elapsed_time += 1
      @distance_traveled += calculate_distance_traveled

      yield(status)
      # Sleep for a second to simulate the passage of time
      sleep 1
    end
  end

  def summary
    {
      total_distance: distance_traveled,
      no_abort_retries: @launch_control.abort_count,
      no_explosions: @launch_control.explode? ? 1 : 0,
      total_fuel_burned: calculate_total_fuel_burned,
      flight_time: flight_time
    }
  end

  private

  def explode_iteration
    @explode_iteration ||= @launch_control.explode? && @launch_control.rand_launch_iteration(distance, current_speed)
  end

  def flight_time
    @flight_time ||= Time.now

    Time.now - @flight_time
  end

  def status
    {
      elapsed_time: elapsed_time,
      distance_traveled: distance_traveled,
      current_fuel_burn_rate: burn_rate / 60,
      current_speed: average_speed,
      time_to_destination: calculate_time_to_destination
    }
  end

  def reached_destination?
    distance_traveled >= distance
  end

  def current_speed
    average_speed / 60
  end

  def calculate_time_to_destination
    remaining_distance = distance - distance_traveled
    remaining_time = remaining_distance / average_speed

    remaining_time.ceil
  end

  def calculate_distance_traveled
    (current_speed * elapsed_time)
  end

  def calculate_total_fuel_burned
    (burn_rate * elapsed_time) / 60
  end
end
