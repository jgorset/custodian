module Custodian
  module Samplers

    class Who < Custodian::Samplers::Sampler
      describe "Logged in users"

      def sample
        `who`.lines.collect { |line| line.split.first }.uniq
      end
    end

  end
end
