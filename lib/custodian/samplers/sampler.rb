module Custodian
  module Samplers

    # Base class for samplers.
    class Sampler

      # Determines whether this sampler is compatible with the system.
      def compatible?
        true
      end

      def sample
        raise NotImplementedError
      end

      def self.describe(description)
        @description = description
      end

      def self.description
        @description
      end

      private

      # Determines whether the given <tt>command</tt> exists on the system.
      def command_exists?(command)
        system "which #{command} > /dev/null 2>&1"
      end

    end

  end
end
