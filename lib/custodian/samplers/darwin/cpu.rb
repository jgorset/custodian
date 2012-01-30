module Custodian
  module Samplers

    class CPU < Custodian::Samplers::Sampler
      describe "CPU usage"

      def self.sample
        cpu = `top -l 1`.match /CPU usage: ([0-9]+\.[0-9]+%) user, ([0-9]+\.[0-9]+%) sys, ([0-9]+\.[0-9]+%) idle/
        
        {
          "User"    => cpu[1],
          "System"  => cpu[2],
          "Idle"    => cpu[3]
        }
      end
    end

  end
end
