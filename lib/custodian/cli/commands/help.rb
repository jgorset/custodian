module Custodian
  module CLI
    module Commands

      class Help < Command
        name "help", "--help", "-h"
        describe "Show this screen"

        include Custodian::CLI::Utilities

        def initialize(options)
          usage
          puts ""

          puts "Commands:\n"
          Custodian::CLI::Commands.each do |command|
            puts "   " + command.names.first + " " * (15 - command.names.first.length) + command.description
          end

          puts ""
          puts "See 'custodian <command> --help' for more information on a particular command."
        end

      end

    end
  end
end
