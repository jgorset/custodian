require "rack"
require "optparse"

module Custodian

  # The CLI class encapsulates Custodian's command-line interface.
  class CLI

    def initialize(arguments)
      options = parse arguments

      Rack::Server.start(
        :app   => Custodian::API.new,
        :Port  => options[:port]
      )
    end

    def self.run!(arguments)
      new arguments
    end

    private

    # Parse the given arguments.
    def parse(arguments)
      options = {
        port: 5100,
        interval: 60
      }

      OptionParser.new do |o|
        o.banner = "Usage: custodian [options]"
        o.version = Custodian::VERSION

        o.on "-p", "--port PORT", "Listen on PORT" do |port|
          options[:port] = port
        end

        o.on "-i", "--interval TIME", "Sample every TIME seconds" do |interval|
          options[:interval] = interval
        end
      end.parse! arguments

      options
    rescue OptionParser::InvalidArgument => e
      error e
    end

    # Print a message and exit with the given code.
    def error(message, code=1)
      puts "custodian: #{message}"
      exit code
    end
  end

end
