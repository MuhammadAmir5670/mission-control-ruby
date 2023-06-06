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
    mission = Missiٍon.new

    mission.print_plan
    mission.fetch_mission_name

    # Logic for running the mission here

    @missions << mission
    prompt('Would you like to run another mission?')
  end
end
