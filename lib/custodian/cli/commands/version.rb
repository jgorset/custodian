module Custodian
  module CLI
    module Commands

      class Version < Command
        name "version", "--version", "-v"
        describe "Show the version"

        def initialize(options)
          puts "custodian version #{Custodian::VERSION}"
        end

      end

    end
  end
end
