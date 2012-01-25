module Custodian
  module CLI

    module Commands
      autoload :Command,    "custodian/cli/commands/command"
      autoload :Start,      "custodian/cli/commands/start"
      autoload :Samplers,   "custodian/cli/commands/samplers"
      autoload :Version,    "custodian/cli/commands/version"
      autoload :Help,       "custodian/cli/commands/help"

      # Returns the command matching the given <tt>identifier</tt>.
      def self.find(identifier)
        each do |command|
          return command.new if command.name.split("::").last.downcase == identifier
        end

        nil
      end

      # Yields each command in turn.
      def self.each
        [Start, Samplers, Version, Help].each do |sampler|
          yield sampler
        end
      end
    end

  end
end
