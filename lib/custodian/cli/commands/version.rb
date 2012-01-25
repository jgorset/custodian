module Custodian
  module CLI
    module Commands

      class Version < Command

        def call(options)
          puts "custodian version #{Custodian::VERSION}"
        end

      end

    end
  end
end
