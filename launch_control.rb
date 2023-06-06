# frozen_string_literal: true
require_relative './mixins/prompt'

# TODO: add documentation for class
class LaunchControl
  include Prompt

  def initialize
    @aborted = 0
    @abort_count = 0
  end

  def prepare_for_launch
    return if engage_afterburner? && disengage_release_structure? && perform_cross_checks?

    abort_launch
  end

  def launch?
    # TODO: logic for
  end

  private

  def abort_launch
    puts 'Mission aborted!'

    @aborted = true
    @abort_count += 1
  end

  def disengage_release_structure?
    return unless prompt('Release support structures?')

    puts 'Support structures released!'
    true
  end

  def engage_afterburner?
    if prompt('Engage afterburner?')
      puts 'Afterburner engaged!'

      true
    else
      return false unless prompt('Retry?')

      puts 'Safe Abort!'

      @abort_count += 1
      engage_afterburner?
    end
  end

  def perform_cross_checks?
    return unless prompt('Perform cross-checks?')

    puts 'Cross-checks performed!'
    true
  end
end
