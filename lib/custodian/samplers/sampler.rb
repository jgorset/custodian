module Custodian
  module Samplers

    # Base class for samplers.
    class Sampler

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
