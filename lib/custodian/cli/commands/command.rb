module Custodian
  module CLI
    module Commands
      
      # <tt>Custodian::CLI::Commands::Command</tt> is the base class
      # for all Custodian commands.
      class Command

        def call(options)
          raise NotImplementedError
        end

      end

    end
  end
end
