# Custodian

Custodian is a lightweight resource monitor that is easy to use and augment.

## Usage

Start Custodian and configure it to sample metrics every 60 seconds and expose
them on port 5100:

    $ custodian start 127.0.0.1:5100 --interval=60

## Augmenting Custodian

Custodian convenes statistics from *samplers*, which are just simple Ruby classes:

    class Who << Custodian::Sampler

      # Return a list of usernames describing logged-in users.
      def sample
        `who`.lines.collect { |line| line.split.first }
      end

    end
