# frozen_string_literal: true

# TODO: add documentation for class
class LaunchControl
  def initialize
    # TODO: attrs to be decided
  end

  def prepare_for_launch
    return if engage_afterburner? && disengage_release_structure? && perform_cross_checks?

    # TODO: logic for abort launch
  end

  def launch?
    # TODO: logic for
  end

  private

  def disengage_release_structure?
    puts 'Support structures released!'
    # TODO: logic for releasing support structures
    true
  end

  def engage_afterburner?
    puts 'Afterburner engaged!'
    # TODO: logic for performing afterburner
    true
  end

  def perform_cross_checks?
    puts 'Cross-checks performed!'
    # TODO: logic for performing cross checks
    true
  end
end
