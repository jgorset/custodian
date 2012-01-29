require "thin"
require "rack"
require "optparse"

module Custodian

  # The CLI class encapsulates Custodian's command-line interface.
  class CLI
    DEFAULT_PORT     = 5100
    DEFAULT_INTERVAL = 60

    # Create a new command-line interface.
    #
    # arguments - An Array of String objects describing arguments
    #             passed to the program (see CLI#parse).
    def initialize(arguments)
      options = parse arguments

      if samplers = options[:samplers]
        load_samplers samplers
      end

      if options.include? :daemonize
        deamonize
      end

      if pidfile = options[:pidfile]
        write_pidfile pidfile
      end

      log "Custodian is accepting connections on port #{options[:port]}"

      compatible_samplers   = Custodian::Samplers.compatible
      incompatible_samplers = Custodian::Samplers.incompatible

      log "#{compatible_samplers.count} compatible samplers."
      compatible_samplers.each do |s|
        log "   - #{s.description}"
      end

      log "#{incompatible_samplers.count} incompatible samplers."
      incompatible_samplers.each do |s|
        log "   - #{s.description}"
      end

      log "CTRL+C to stop"

      Thin::Logging.silent = true

      Thin::Server.start '0.0.0.0', options[:port] do
        use Rack::CommonLogger
        use Rack::ShowExceptions

        run Custodian::API.new
      end
    end

    private
    
    # Load samplers from the given directories.
    #
    # directories - An Array of Strings describing paths to directories
    #               that contain samplers.
    #
    # Returns nothing.
    def load_samplers(directories)
      directories.each do |directory|
        Custodian::Samplers.load directory
      end
    end

    # Write the process id to the given file.
    #
    # file - A String describing an path to a file. If the file does not exist, it
    #        will be created. If the file already exists, it will be overwritten.
    #
    # Returns nothing.
    def write_pidfile(file)
      File.open file, "w" do |file|
        file << Process.id
      end
    end

    # Daemonize the process.
    def deamonize
      Process.daemon
    end

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
      options = {
        port:     DEFAULT_PORT,
        interval: DEFAULT_INTERVAL
      }

      OptionParser.new do |o|
        o.banner  = "Usage: custodian [options]"
        o.version = Custodian::VERSION

        o.on "-p", "--port PORT", "Listen on PORT (default #{options[:port]})" do |port|
          options[:port] = port
        end

        o.on "-s", "--samplers DIR", "Load samplers from DIR" do |samplers|
          options[:samplers] = samplers.split(":")
        end

        o.on "--daemonize", "Daemonize the server" do
          options[:daemonize] = true
        end

        o.on "--pidfile FILE", "Write the PID to FILE" do |pidfile|
          options[:pidfile] = pidfile
        end
      end.parse! arguments

      options
    rescue OptionParser::InvalidOption => e
      error e
    end

    # Log a message to STDOUT.
    #
    # message - A String describing a message.
    def log(message)
      puts ">> #{message}"
    end

    # Print a message and exit with the given code.
    #
    # message - A String describing the message to print.
    # code    - An Integer describing the exit code (defaults to 1).
    def error(message, code = 1)
      puts "custodian: #{message}"
      exit code
    end
  end

end
