require "json"

module Custodian

  # Reports describe the outcome of one particular sample.
  class Report

    def initialize(sampler)
      @sampler = sampler
    end

    # Return the human-readable name of the sampler this
    # report was generated from.
    def name
      @sampler.class.name.split("::").last.downcase
    end

    # Return the value of this report.
    def value
      @sampler.sample
    end

    def to_hash
      {
        name => value
      }
    end

  end

end
