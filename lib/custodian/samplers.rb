module Custodian
  module Samplers    
    autoload :Sampler,    "custodian/samplers/sampler"

    autoload :Who,        "custodian/samplers/who"

    @@samplers = [
      Who
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

    # Make a sample.
    def self.sample
      @@samplers.collect do |sampler|
        Custodian::Report.new(sampler)
      end
    end
  end
end
