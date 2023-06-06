# frozen_string_literal: true
require_relative './launch_control'

# TODO: add documentation for class
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

    prepare_for_launch

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
    @explode_iteration ||= @launch_control.explode? && @launch_control.rand_explode_iteration(distance, current_speed)
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
