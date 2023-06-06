# frozen_string_literal: true

require_relative './mission'

# TODO: add documentation for class
class MissionControl
  def initialize
    @missions = []
  end

  def self.start
    new.start
  end

  def start
    puts 'Welcome to Mission Control!'

    loop do
      break unless run_mission
    end

    # TODO: logic for displaying the summary
    puts 'Exiting Mission Control. Goodbye!'
  end

  private

  def run_mission
    mission = Mission.new

    mission.print_plan
    mission.fetch_mission_name

    # Logic for running the mission here

    @missions << mission
    prompt('Would you like to run another mission?')
  end

  private

  def display_mission_summary(summary)
    puts 'Mission summary:'
    puts "  Total distance traveled: #{summary[:total_distance].round(2)} km"
    puts "  Number of abort and retries: #{summary[:no_abort_retries]}"
    puts "  Number of explosions: #{summary[:no_explosions]}"
    puts "  Total fuel burned: #{summary[:total_fuel_burned]} liters"
    puts "  Flight time: #{format_time(summary[:flight_time])}"
  end

  def format_time(time)
    hours = time / 3600
    minutes = (time % 3600) / 60
    seconds = time % 60

    format('%02d:%02d:%02d', hours, minutes, seconds)
  end
end
