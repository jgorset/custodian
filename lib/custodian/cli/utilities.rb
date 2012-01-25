module Custodian
  module CLI

    # <tt>Custodian::CLI::Utilities</tt> encapsulates command-line utilities.
    module Utilities

      # Print <tt>message</tt> and exit with the given <tt>code/<tt>.
      def error(message, code=1)
        puts "custodian: #{message}"
        exit code
      end

    end
  end
end
