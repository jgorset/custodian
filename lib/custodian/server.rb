require "optparse"
require "json"
require "rack"

module Custodian

  class Server
    autoload :Application, "custodian/server/application"

    # Start the server.
    def self.start(options)
      options = parse options

      Rack::Server.start(
        :app   => Custodian::Server::Application.new,
        :Port  => options[:port]
      )
    end

    private

    def self.default_options
      {
        :port     => 5100,
        :interval => 60
      }
    end

    # Parse command-line arguments.
    def self.parse(arguments)
      options = default_options

      OptionParser.new do |o|
        o.program_name = "git.io"
        o.banner = "Usage: custodian [options]"
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
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
      error e
    end

    # Print <tt>message</tt> and exit with the given <tt>code</tt>.
    def self.error(message, code=1)
      puts "custodian: #{message}"
      exit code
    end

  end

end
