module Custodian
  module CLI
    module Utilities

      # Print <tt>message</tt> and exit with the given <tt>code/<tt>.
      def error(message, code=1)
        puts "custodian: #{message}"
        exit code
      end

    end
  end
end