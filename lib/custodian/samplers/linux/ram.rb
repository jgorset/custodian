module Custodian
  module Samplers

    class RAM < Custodian::Samplers::Sampler
      describe "RAM usage"

      def sample
        free = `free -m`.match /Mem: +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+)/

        {
          "Total"   => "#{free[1]} MB",
          "Used"    => "#{free[2]} MB",
          "Free"    => "#{free[3]} MB",
          "Buffers" => "#{free[4]} MB",
          "Cached"  => "#{free[5]} MB"
        }        
      end
    end

  end
end
