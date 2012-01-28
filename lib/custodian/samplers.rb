require "pathname"

module Custodian
  
  # The Samplers module encapsulates a collection of samplers
  # for various metrics.
  module Samplers    
    autoload :Sampler,    "custodian/samplers/sampler"
    autoload :Utilities,  "custodian/samplers/utilities"

    @samplers = []

    # List all samplers.
    #
    # Returns an Array of Sampler objects.
    def self.list
      @samplers
    end

    # List compatible samplers.
    #
    # Returns an Array of Sampler objects that are compatible
    # with this system.
    def self.compatible
      @samplers.select { |s| s.compatible? }
    end

    # List incompatible samplers.
    #
    # Returns an Array of Sampler objects that are incompatible
    # with this system.
    def self.incompatible
      @samplers.reject { |s| s.compatible? }
    end

    # Register the given sampler.
    #
    # sampler - An object that inherits from Sampler.
    #
    # Returns nothing.
    def self.register(sampler)
      @samplers << sampler
    end

    # Remove the given sampler.
    #
    # sampler - An object that inherits from Sampler.
    def self.remove(sampler)
      @samplers.delete(sampler)
    end

    # Replace one sampler with another.
    #
    # a - An object that inherits from Sampler.
    # b - Another object that inherits from Sampler.
    #
    # Returns nothing.
    def self.replace(a, b)
      remove a
      register b
    end

    # Load samplers from the given directory.
    #
    # directory - A String describing a path to a directory. If the path is relative,
    #             it will be expanded from the current working directory. If the path
    #             is prefixed with a tilde, it will be expanded from the current user's
    #             home directory. If the path is prefixed with a tilde immediately followed
    #             by a username, it will be expanded from that user's home directory.
    #
    # Returns nothing.
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
  end
end
