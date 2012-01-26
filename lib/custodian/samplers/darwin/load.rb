module Custodian
  module Samplers

    class Load < Custodian::Samplers::Sampler
      describe "Load averages"

      def sample
        `uptime`[/load averages: (.*)/, 1].split
      end
    end

  end
end
