# frozen_string_literal: true

# TODO: add documentation for class
class Rocket
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
end
