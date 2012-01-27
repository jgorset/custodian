require "pathname"

module Custodian
  module Samplers    
    autoload :Sampler,    "custodian/samplers/sampler"
    autoload :Utilities,  "custodian/samplers/utilities"

    @samplers = []

    # Lists all samplers.
    def self.list
      @samplers
    end

    # Lists compatible samplers.
    def self.compatible
      @samplers.select { |s| s.compatible? }
    end

    # Lists incompatible samplers.
    def self.incompatible
      @samplers.reject { |s| s.compatible? }
    end

    # Registers the given sampler.
    def self.register(sampler)
      @samplers << sampler
    end

    # Removes the given sampler.
    def self.remove(sampler)
      @samplers.delete(sampler)
    end

    # Replaces one sampler with another.
    def self.replace(a, b)
      remove a
      register b
    end

    # Loads samplers from the given directory.
    def self.load(directory)
      path = Pathname.new directory

      # Allow referencing directories by relative and home path.
      path = path.expand_path unless path.absolute?

      unless path.directory?
        raise StandardError, "#{directory} is not a directory"
      end

      path.each_child do |child|
        require child if child.file?
      end
    end

    # Load samplers for darwin.
    if OS.darwin?
      load File.dirname(__FILE__) + "/samplers/darwin"
    end

    # Load samplers for linux.
    if OS.linux?
      load File.dirname(__FILE__) + "/samplers/linux"
    end

    # Load platform-agnostic samplers.
    load File.dirname(__FILE__) + "/samplers/agnostic"
  end
end
