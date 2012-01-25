require "active_support/core_ext/string/inflections"

module Custodian
  module CLI
    module Commands

      class Samplers < Command

        def initialize(options)
          samplers = Custodian::Samplers.list

          puts "#{samplers.count} samplers:"
          puts ""

          samplers.each do |sampler|
            puts "   " + sampler.name.demodulize.underscore  + " " * (20 - sampler.name.demodulize.underscore.length) + sampler.description
          end

        end

        def self.description
          "Show samplers"
        end

      end

    end
  end
end
