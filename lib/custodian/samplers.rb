module Custodian
  module Samplers    
    autoload :Sampler,    "custodian/samplers/sampler"

    autoload :Who,        "custodian/samplers/who"
    autoload :Load,       "custodian/samplers/load"

    @@samplers = [
      Who, Load
    ]

    def self.list
      @@samplers
    end

    # Register the given <tt>sampler</tt>.
    def self.register(sampler)
      @@samplers << sampler
    end

    # Remove the given <tt>sampler</tt>.
    def self.remove(sampler)
      @@samplers.delete(sampler)
    end

    # Replace the given sampler <tt>a</tt> with sampler <tt>b</tt>.
    def self.replace(a, b)
      remove a
      register b
    end

    # Return a list of compatible samplers.
    def self.sample
      @@samplers.collect do |sampler|
        sampler = sampler.new

        Custodian::Report.new(sampler) if sampler.compatible?
      end.compact
    end
  end
end
