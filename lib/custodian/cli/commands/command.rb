module Custodian
  module CLI
    module Commands

      class Command
        @@aliases = []

        def call(options)
          raise NotImplementedError
        end

        def self.aliases=(*aliases)
          @@aliases << aliases
        end

      end

    end
  end
end
