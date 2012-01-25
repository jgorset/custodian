# Custodian

Custodian is a lightweight resource monitor that is easy to use and augment.

## Usage

Start Custodian and configure it to sample metrics every 60 seconds and expose
them over HTTP on port 5100:

    $ custodian start --port=5100 --interval=60

Metrics are serialized as JSON:

    $ curl http://localhost:5100/
    {
      "who": [
        "jgorset",
        "drevil"
      ]
    }

## Augmenting Custodian

Custodian aggregates statistics from *samplers*, which are just simple Ruby classes:

    class Who << Custodian::Samplers::Sampler

      # Return a list of logged in users.
      def sample
        `who`.lines.collect { |line| line.split.first }
      end

    end
