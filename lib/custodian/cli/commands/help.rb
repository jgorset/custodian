module Custodian
  module CLI
    module Commands

      class Help < Command
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

        def self.names
          super + ["-h", "--help"]
        end
        
        def self.description
          "Show this screen"
        end

      end

    end
  end
end
