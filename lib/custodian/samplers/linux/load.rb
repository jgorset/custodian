module Custodian
  module Samplers

    class Load < Custodian::Samplers::Sampler
      describe "Load averages"

      def self.sample
        uptime = `uptime`.match /load average: ([0-9.]+), ([0-9.]+), ([0-9.]+)/

        {
          "Last 5 minutes"    => uptime[1],
          "Last 10 minutes"   => uptime[2],
          "Last 15 minutes"   => uptime[3]
        }
      end
    end

  end
end
