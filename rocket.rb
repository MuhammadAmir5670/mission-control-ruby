# frozen_string_literal: true

# TODO: add documentation for class
class Rocket
  attr_reader :distance, :burn_rate,
              :average_speed, :distance_traveled

  def initialize(distance, burn_rate, average_speed)
    @launch_control = LaunchControl.new
    @distance = distance
    @burn_rate = burn_rate
    @average_speed = average_speed
    @distance_traveled = 0
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
    # TODO: logic for launching a rocket
  end

  private

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
