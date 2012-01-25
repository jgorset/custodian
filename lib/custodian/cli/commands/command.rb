require "optparse"

module Custodian
  module CLI
    module Commands

      # <tt>Custodian::CLI::Commands::Command</tt> is the base class
      # for all Custodian commands.
      class Command
        include Custodian::CLI::Utilities

        def self.invoke(options)
          new(options)
        end

        # Returns a list of strings that invoke this command.
        def self.names
          [name.split("::").last.downcase]
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
