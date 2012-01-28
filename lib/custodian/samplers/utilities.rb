module Custodian
  module Samplers

    # Utility methods for samplers.
    module Utilities

      # Determine whether the given program exists.
      #
      # program - A String describing the name of a program.
      #
      # Returns true if the program exists, or false if it doesn't.
      def self.program_exists?(program)
        system "which #{command} > /dev/null 2>&1"
      end

      # Determine whether the given directory exists.
      #
      # directory - A String describing the path to a directory.
      #
      # Returns true if the directory exists, or false if it doesn't.
      def self.directory_exists?(directory)
        Pathname.new(directory).directory?
      end

      # Determine whether the given file exists.
      #
      # file - A String describing the path to a file.
      #
      # Returns true if the file exists, or false if it doesn't.
      def self.file_exists?(file)
        Pathname.new(file).file?
      end

    end

  end
end
