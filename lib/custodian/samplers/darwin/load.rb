module Custodian
  module Samplers

    class Load < Custodian::Samplers::Sampler
      describe "Samples load averages"

      def sample
        `uptime`[/load averages: (.*)/, 1].split
      end
    end

  end
end
