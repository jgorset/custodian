module Custodian
  module Samplers

    # Base class for samplers.
    class Sampler
      include Custodian::Samplers::Utilities

      class << self

        # Describe the sampler.
        #
        # description - A String describing the sampler.
        #
        # Returns nothing.
        def describe(description)
          @description = description
        end

        # Returns the sampler's description.
        def description
          @description
        end

        # Make a sample from this sampler.
        #
        # Examples
        #
        #   CPU.sample # => { "User" => "10%", "System" => "5%", "Idle" => "85%" }
        #
        # Returns an Integer, Symbol, String, Hash or Array (or any combination thereof)
        # describing the outcome of the sample.
        def sample
          nil
        end

        # Determine whether the sampler is compatible with this system.
        #
        # Returns true if it is compatible, or false if it isn't.
        def compatible?
          true
        end

      end

      private

      # Register samplers for classes that inherit from this class.
      #
      # sampler - The Class that inherited this class.
      #
      # Returns nothing.
      def self.inherited(sampler)
        Custodian::Samplers.register(sampler)
      end
    end

  end
end
