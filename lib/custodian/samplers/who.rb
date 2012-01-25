module Custodian
  module Samplers

    # = Who
    #
    # Sample the logged in users on the system.
    #
    # == Compatibility
    #
    # This sampler should be compatible with any system that has
    # the <tt>who</tt> command.
    class Who < Custodian::Samplers::Sampler
      describe "Logged in users"

      def compatible?
        command_exists? "who"
      end

      # Return a list of strings describing logged in users.
      def sample
        `who`.lines.collect { |line| line.split.first }.uniq
      end

    end

  end
end
