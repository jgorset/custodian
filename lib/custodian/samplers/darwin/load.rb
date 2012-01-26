module Custodian
  module Samplers

    class Load < Custodian::Samplers::Sampler
      describe "Load averages"

      def sample
        uptime = `uptime`[/load averages: (.*)/, 1].split
        
        {
          "Last 5 minutes"    => uptime[0],
          "Last 10 minutes"   => uptime[1],
          "Last 15 minutes"   => uptime[2]
        }
      end
    end

  end
end
