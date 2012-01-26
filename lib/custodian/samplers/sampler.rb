module Custodian
  module Samplers

    # Base class for samplers.
    class Sampler
      include Custodian::Samplers::Utilities

      # Determines whether the sampler is compatible with this system.
      def compatible?
        true
      end

      class << self

        # Describes the sampler.
        def describe(description)
          @description = description
        end

        # Returns the sampler's description.
        def description
          @description
        end

        def sample
          new.sample
        end

        def compatible?
          new.compatible?
        end

      end

      def description
        self.class.description
      end

      private

      # Register samplers for classes that inherit from this class.
      def self.inherited(sampler)
        Custodian::Samplers.register(sampler)
      end
    end

  end
end
