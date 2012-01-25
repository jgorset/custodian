require "optparse"

module Custodian
  module CLI
    module Commands

      # Base class for commands.
      class Command
        include Custodian::CLI::Utilities

        def self.invoke(options)
          new(options)
        end

        class << self

          # Returns a string describing this command.
          def description
            @description
          end

          # Returns a list of strings that invoke this command.
          def names
            @names
          end

          # Describes the command with the given <tt>description</tt>.
          def describe(description)
            @description = description
          end

          # Names the command with the given <tt>names</tt>.
          def name(*names)
            @names = names
          end

        end

        private

        def parse(arguments)
          OptionParser.new do |options|
            options.program_name = "custodian #{self.class.names.last}"
            options.banner = "Usage: custodian #{self.class.names.last} [options]"
            options.version = Custodian::VERSION

            yield options
          end.parse! arguments
        rescue OptionParser::InvalidOption => e
          error e
        end

      end

    end
  end
end
