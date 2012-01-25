module Custodian
  module CLI
    module Commands

      class Version < Command

        def initialize(options)
          puts "custodian version #{Custodian::VERSION}"
        end

        def self.names
          super + ["-v", "--version"]
        end
        
        def self.description
          "Show the version"
        end

      end

    end
  end
end
