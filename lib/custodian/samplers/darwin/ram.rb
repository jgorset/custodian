module Custodian
  module Samplers

    class RAM < Custodian::Samplers::Sampler
      describe "RAM usage"

      def self.sample
        vmstat = `vm_stat`

        pages_free      = vmstat[/Pages free: +([0-9]+)/, 1].to_i + vmstat[/Pages speculative: +([0-9]+)/, 1].to_i
        pages_inactive  = vmstat[/Pages inactive: +([0-9]+)/, 1].to_i
        pages_active    = vmstat[/Pages active: +([0-9]+)/, 1].to_i
        pages_wired     = vmstat[/Pages wired down: +([0-9]+)/, 1].to_i
        page_ins        = vmstat[/Pageins: +([0-9]+)/, 1].to_i
        page_outs       = vmstat[/Pageouts: +([0-9]+)/, 1].to_i

        {
          "Free"      => "#{pages_free * 4096 / 1024 / 1024} MB",
          "Inactive"  => "#{pages_inactive * 4096 / 1024 / 1024} MB",
          "Active"    => "#{pages_active * 4096 / 1024 / 1024} MB",
          "Wired"     => "#{pages_wired * 4096 / 1024 / 1024} MB",
          "Page ins"  => "#{page_ins * 4096 / 1024 / 1024} MB",
          "Page outs" => "#{page_outs * 4096 / 1024 / 1024} MB"
        }
      end
    end

  end
end
