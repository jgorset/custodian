module Custodian

  # The OS module encapsulates Custodian's operating
  # system detection algorithms.
  module OS

    # Determine whether the operating system is darwin.
    #
    # Returns a boolean describing whether the operating system
    # is darwin.
    def self.darwin?
      RUBY_PLATFORM.downcase.include? "darwin"
    end

    # Determine whether the operating system is linux.
    #
    # Returns a boolean describing whether the operating system
    # is linux.
    def self.linux?
      RUBY_PLATFORM.downcase.include? "linux"
    end

  end

end
