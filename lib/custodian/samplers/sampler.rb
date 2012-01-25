module Custodian
  module Samplers

    # Base class for samplers.
    class Sampler

      def sample
        raise NotImplementedError
      end

      def sample!
        sample
      rescue Exception => e
        raise Error, "An error occurred with #{self.class.name}: #{e.message}"
      end

      def self.describe(description)
        @description = description
      end

      def self.description
        @description
      end

      private

      # Register samplers for classes that inherit from this class.
      def self.inherited(sampler)
        Custodian::Samplers.register(sampler)
      end

      class Error < StandardError; end
    end

  end
end
