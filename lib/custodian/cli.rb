require "thin"
require "rack"
require "optparse"

module Custodian

  # The CLI class encapsulates Custodian's command-line interface.
  class CLI

    def initialize(arguments)
      options = parse arguments

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

    # Parse the given arguments.
    def parse(arguments)
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

        o.on "-s", "--samplers DIR", "Load samplers from DIR" do |directories|
          directories.split(":").each { |directory| Custodian::Samplers.load directory }
        end
      end.parse! arguments

      options
    rescue OptionParser::InvalidOption => e
      error e
    end

    # Print a message and exit with the given code.
    def error(message, code=1)
      puts "custodian: #{message}"
      exit code
    end
  end

end
