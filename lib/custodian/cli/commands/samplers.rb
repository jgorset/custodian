module Custodian
  module CLI
    module Commands

      class Samplers < Command

        def call(options)
          samplers                = Custodian::Samplers.list
          compatible_samplers     = samplers.select { |s| s.new.compatible? }
          incompatible_samplers   = samplers.reject { |s| s.new.compatible? }

          unless compatible_samplers.empty?
            puts "#{compatible_samplers.count} compatible samplers:"
            puts ""

            compatible_samplers.each do |sampler|
              puts "   " + sampler.name.split("::").last.downcase
            end
          end

          unless compatible_samplers.empty? && incompatible_samplers.empty?
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

      end

    end
  end
end
