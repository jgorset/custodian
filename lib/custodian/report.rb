require "active_support/inflector"

module Custodian

  # Reports describe the outcome of a particular sample.
  class Report

    def initialize(sampler)      
      @sampler = sampler
      @description = sampler.class.description
      @sample = sampler.sample!
    end

    def to_hash
      {
        @sampler.class.name.demodulize.underscore => {
          :description => @description,
          :sample => @sample
        }
      }
    end

  end

end
