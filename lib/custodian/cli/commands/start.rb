require "rack"

module Custodian
  module CLI
    module Commands

      class Start < Command

        def initialize(options)
          options = parse options

          Rack::Server.start(
            :app   => Custodian::API.new,
            :Port  => options[:port]
          )
        end
        
        def self.description
          "Start the server"
        end

        private

        # Parse command-line arguments.
        def parse(arguments)
          options = {
            :port     => 5100,
            :interval => 60
          }

          super arguments do |o|
            o.on "-p", "--port PORT", "Listen on the given port" do |port|
              options[:port] = port
            end

            o.on "-i", "--interval TIME", "Sample every TIME seconds" do |interval|
              options[:interval] = interval
            end

            o.on "-s", "--samplers PATH", "Load samplers from the given path" do |samplers|
              options[:samplers] = samplers
            end
          end

          options
        end

      end

    end
  end
end
