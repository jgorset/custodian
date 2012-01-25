require "active_support/core_ext/string/inflections"

module Custodian
  module CLI
    module Commands

      class Samplers < Command
        name "samplers"
        describe "Show samplers"

        def initialize(options)
          samplers = Custodian::Samplers.list

          puts "#{samplers.count} samplers:"

          samplers.each do |sampler|
            puts "   " + sampler.name.demodulize.underscore  + " " * (15 - sampler.name.demodulize.underscore.length) + sampler.description
          end

        end

      end

    end
  end
end
