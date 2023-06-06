# frozen_string_literal: true

# TODO: add documentation string
module Prompt
  def prompt(message)
    print "#{message} (Y/n) "
    choice = gets.chomp.downcase

    ['y', ''].include?(choice)
  end
end
