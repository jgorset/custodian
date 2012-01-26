module Custodian
  module Samplers    
    autoload :Sampler,    "custodian/samplers/sampler"

    @samplers = []

    # List all samplers.
    def self.list
      @samplers
    end

    # Register the given sampler.
    def self.register(sampler)
      @samplers << sampler
    end

    # Remove the given sampler.
    def self.remove(sampler)
      @samplers.delete(sampler)
    end

    # Replace one sampler with another.
    def self.replace(a, b)
      remove a
      register b
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
