# Custodian

Custodian is a lightweight resource monitor that is easy to use and augment.

## Usage

### Server

Start Custodian and configure it to sample metrics every 60 seconds and expose
them over HTTP on port 5100:

    $ custodian start --port=5100 --interval=60

#### Augmenting Custodian

Custodian aggregates statistics from *samplers*, which are just simple Ruby classes:

    class Who << Custodian::Samplers::Sampler

      # Return a list of logged in users.
      def sample
        `who`.lines.collect { |line| line.split.first }
      end

    end

Custodian ships with samplers for popular metrics such as CPU, RAM and disk usage, but
you can add your own with the `--samplers` option:

    $ custodian start --samplers=/home/jgorset/samplers ...

### Clients

Unless you're crazy about JSON, you'll probably want to consume Custodian's API
with a *client*. Unfortunately, there are no clients for Custodian yet — you should make one!
