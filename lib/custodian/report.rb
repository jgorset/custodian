require "json"
require "active_support/inflector"

module Custodian

  # <tt>Custodian::Report</tt> instances describe the outcome of a particular sample.
  class Report

    def initialize(sampler)
      @sampler = sampler
    end

    def to_hash
      {
        @sampler.class.name.demodulize.underscore => {
          :description => @sampler.class.description,
          :sample => @sampler.sample
        }
      }
    end

  end

end
