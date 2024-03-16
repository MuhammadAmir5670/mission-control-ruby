# frozen_string_literal: true

# Prompt module provides a utility method for prompting user input with a yes/no question.
#
# Usage:
#   include Prompt
#
#   if prompt('Continue?')
#     # Perform actions if user chooses to continue
#   else
#     # Perform actions if user chooses not to continue
#   end
#
# Public Instance Methods:
#   - prompt: Prompts the user with a yes/no question and returns a boolean value indicating the choice.
#
module Prompt
  def prompt(message)
    print "#{message} (Y/n) "
    choice = gets.chomp.downcase

    ['y', ''].include?(choice)
  end
end
