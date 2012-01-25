module Custodian
  module Samplers

    class Load < Custodian::Samplers::Sampler
      describe "Load averages"

      def compatible?
        command_exists? "uptime"
      end

      def sample
        `uptime`[/load averages: (.*)/, 1].split
      end
    end

  end
end
