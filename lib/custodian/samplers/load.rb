module Custodian
  module Samplers

    # = Who
    #
    # Sample the load averages.
    #
    # == Compatibility
    #
    # This sampler should be compatible with any system that has
    # the <tt>uptime</tt> command.
    class Load < Custodian::Samplers::Sampler

      def compatible?
        command_exists? "uptime"
      end

      # Return a list of strings describing logged in users.
      def sample
        `uptime`[/load averages: (.*)/, 1]
      end

    end

  end
end
