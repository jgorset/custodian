module Custodian
  module Samplers    
    autoload :Sampler,    "custodian/samplers/sampler"

    @samplers = []

    # List all samplers.
    def self.list
      @samplers
    end

    # Register the given <tt>sampler</tt>.
    def self.register(sampler)
      @samplers << sampler
    end

    # Remove the given <tt>sampler</tt>.
    def self.remove(sampler)
      @samplers.delete(sampler)
    end

    # Replace the given sampler <tt>a</tt> with sampler <tt>b</tt>.
    def self.replace(a, b)
      remove a
      register b
    end

    # Produce reports for each of the samplers.
    def self.sample
      @samplers.collect do |sampler|
        begin
          Custodian::Report.new(sampler.new)
        rescue Sampler::Error => e
          warn "An error occurred with #{sampler.name}: #{e.message}"
        end
      end.compact
    end

    # Load samplers for darwin.
    if RUBY_PLATFORM.downcase.include? "darwin"
      Dir[File.dirname(__FILE__) + "/samplers/darwin/*"].each { |file| require file }
    end

    # Load samplers for linux.
    if RUBY_PLATFORM.downcase.include? "linux"
      Dir[File.dirname(__FILE__) + "/samplers/linux/*"].each { |file| require file }
    end
    
    # Load platform-agnostic samplers.
    Dir[File.dirname(__FILE__) + "/samplers/agnostic/*"].each { |file| require file }
  end
end
