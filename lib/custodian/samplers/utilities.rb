module Custodian
  module Samplers

    # Utility methods for samplers.
    module Utilities

      # Determines whether the given program exists.
      def self.program_exists?(program)
        system "which #{command} > /dev/null 2>&1"
      end

      # Determines whether the given directory exists.
      def self.directory_exists?(directory)
        Pathname.new(directory).directory?
      end

      # Determines whether the given file exists.
      def self.file_exists?(file)
        Pathname.new(file).file?
      end

      # Determines whether the sampler is compatible with this system.
      def compatible?
        true
      end

      class << self

        def describe(description)
          @description = description
        end

        def description
          @description
        end

        def sample
          new.sample
        end

      end

      private

      # Register samplers for classes that inherit from this class.
      def self.inherited(sampler)
        Custodian::Samplers.register(sampler)
      end
    end

  end
end
