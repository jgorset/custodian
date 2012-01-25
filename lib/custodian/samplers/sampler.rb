module Custodian
  module Samplers

    # Base class for samplers.
    class Sampler

      def sample
        raise NotImplementedError
      end

    end

  end
end
