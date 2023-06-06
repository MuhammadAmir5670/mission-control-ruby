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

    display_summary
    puts 'Exiting Mission Control. Goodbye!'
  end

  private

  def run_mission
    mission = Mission.new

    mission.print_plan
    mission.fetch_mission_name

    if mission.proceed?
      mission.start

      display_mission_summary(mission.summary)
    end

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

  def display_summary
    puts 'Final Summary:'
    total_distance = @missions.sum { |mission| mission.summary[:total_distance] }
    total_abort_retries = @missions.sum { |mission| mission.summary[:no_abort_retries] }
    total_explosions = @missions.sum { |mission| mission.summary[:no_explosions] }
    total_fuel_burned = @missions.sum { |mission| mission.summary[:total_fuel_burned] }
    total_flight_time = @missions.sum { |mission| mission.summary[:flight_time] }

    puts "  Total distance traveled (for all missions combined): #{total_distance.round(2)} km"
    puts "  Number of abort and retries (for all missions combined): #{total_abort_retries}"
    puts "  Number of explosions (for all missions combined): #{total_explosions}"
    puts "  Total fuel burned (for all missions combined): #{total_fuel_burned} liters"
    puts "  Total flight time (for all missions combined): #{format_time(total_flight_time)}"
  end

  def format_time(time)
    hours = time / 3600
    minutes = (time % 3600) / 60
    seconds = time % 60

    format('%02d:%02d:%02d', hours, minutes, seconds)
  end
end
