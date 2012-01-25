module Custodian
  module CLI
    module Commands

      class Help < Command

        def initialize(options)
          puts help
        end

        private

        def help
          string =  "usage: custodian <command> [options]\n"
          string << "\n"

          string << "Commands:\n"
          Custodian::CLI::Commands.each do |command|
            string << "   " + command.name.split("::").last.downcase + "\n"
          end

          string
        end

      end

    end
  end
end
