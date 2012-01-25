require "rack"

module Custodian
  module CLI
    module Commands

      # = Start
      #
      # Starts the custodian server.
      class Start < Command
        include Custodian::CLI::Utilities

        def call(options)
          options = parse options

          Rack::Server.start(
            :app   => Custodian::API.new,
            :Port  => options[:port]
          )
        end

        private

        def default_options
          {
            :port     => 5100,
            :interval => 60
          }
        end

        # Parse command-line arguments.
        def parse(arguments)
          options = default_options

          OptionParser.new do |o|
            o.program_name = "custodian start"
            o.banner = "Usage: custodian start [options]"
            o.version = Custodian::VERSION

            o.on "-p", "--port PORT", "Listen on the given port" do |port|
              options[:port] = port
            end

            o.on "-i", "--interval TIME", "Sample every TIME seconds" do |interval|
              options[:interval] = interval
            end

            o.on "-s", "--samplers PATH", "Load samplers from the given path" do |samplers|
              options[:samplers] = samplers
            end
          end.parse!(arguments)

          options
        rescue OptionParser::InvalidOption => e
          error e
        end

      end

    end
  end
end
