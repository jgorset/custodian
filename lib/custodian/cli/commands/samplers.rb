require "active_support/core_ext/string/inflections"

module Custodian
  module CLI
    module Commands

      class Samplers < Command

        def initialize(options)
          samplers                = Custodian::Samplers.list
          compatible_samplers     = samplers.select { |s| s.new.compatible? }
          incompatible_samplers   = samplers.reject { |s| s.new.compatible? }

          unless compatible_samplers.empty?
            puts "#{compatible_samplers.count} compatible samplers:"
            puts ""

            compatible_samplers.each do |sampler|
              puts "   " + sampler.name.demodulize.underscore  + " " * (20 - sampler.name.demodulize.underscore.length) + sampler.description
            end
          end

          if compatible_samplers.empty? && incompatible_samplers.empty?
            puts ""
          end

          unless incompatible_samplers.empty?
            puts "#{incompatible_samplers.count} incompatible samplers:"
            puts ""

            incompatible_samplers.each do |sampler|
              puts "   " + sampler.name.split("::").last.downcase
            end
          end

        end

        def self.description
          "Show samplers"
        end

      end

    end
  end
end
