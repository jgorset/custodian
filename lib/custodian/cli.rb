require "thin"
require "rack"
require "optparse"

module Custodian

  # The CLI class encapsulates Custodian's command-line interface.
  class CLI

    # Create a new command-line interface.
    #
    # arguments - An Array of String objects describing arguments
    #             passed to the program (see CLI#parse).
    def initialize(arguments)
      options = parse arguments

      # Load custom samplers
      if options.include? :samplers
        options[:samplers].each { |directory| Custodian::Samplers.load directory }
      end

      puts ">> Custodian is accepting connections on port #{options[:port]}"

      compatible_samplers   = Custodian::Samplers.compatible
      incompatible_samplers = Custodian::Samplers.incompatible

      # List compatible samplers
      unless compatible_samplers.empty?
        puts ">> #{compatible_samplers.count} compatible samplers:"
        compatible_samplers.each { |s| puts ">>    - #{s.description}" }
      end

      # List incompatible samplers
      unless incompatible_samplers.empty?
        puts ">> #{incompatible_samplers.count} incompatible samplers:"
        incompatible_samplers.each { |s| puts ">>    - #{s.description}" }
      end

      puts ">> CTRL+C to stop"

      # You talk too much, Thin.
      Thin::Logging.silent = true

      Thin::Server.start '0.0.0.0', options[:port] do
        use Rack::CommonLogger
        use Rack::ShowExceptions

        run Custodian::API.new
      end
    end

    private

    # Parse the given arguments or exit with an error if they are malformed and/or invalid.
    #
    # arguments - An Array of String objects describing arguments passed to the program:
    #             "-p", "--port"     - An integer describing the port to listen on.
    #             "-s", "--samplers" - A colon-separated list of directories from
    #                                  which to load samplers.
    #
    # Returns a Hash of options derived from the given arguments:
    #   :port     - An Integer describing the port to listen on.
    #   :samplers - An Array of String objects describing paths to load samplers from.
    def parse(arguments)

      # Default options
      options = {
        port: 5100,
        interval: 60
      }

      OptionParser.new do |o|
        o.banner = "Usage: custodian [options]"
        o.version = Custodian::VERSION

        o.on "-p", "--port PORT", "Listen on PORT (default #{options[:port]})" do |port|
          options[:port] = port
        end

        o.on "-s", "--samplers DIR", "Load samplers from DIR" do |samplers|
          options [:samplers] = samplers.split(":")
        end
      end.parse! arguments

      options
    rescue OptionParser::InvalidOption => e
      error e
    end

    # Print a message and exit with the given code.
    #
    # message - A String describing the message to print.
    # code    - An Integer describing the exit code.
    def error(message, code=1)
      puts "custodian: #{message}"
      exit code
    end
  end

end
