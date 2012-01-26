module Custodian

  # The OS module encapsulates Custodian's operating
  # system detection algorithms.
  module OS

    def self.darwin?
      RUBY_PLATFORM.downcase.include? "darwin"
    end

    def self.linux?
      RUBY_PLATFORM.downcase.include? "linux"
    end

  end

end
