# Custodian

Custodian is a lightweight resource monitor that makes it really easy
to sample metrics and display them anywhere.

## Usage

### Server

Start Custodian and configure it to sample metrics every 60 seconds and expose
them over HTTP on port 5100:

    $ custodian start --port=5100 --interval=60

#### Samplers

Custodian aggregates statistics from *samplers*, and ships with samplers for
popular metrics such as CPU, RAM and disk usage.

    $ custodian samplers
    15 compatible samplers:

    cpu         CPU statistics
    ram         RAM statistics
    disk        Disk statistics
    ...

##### Writing your own sampler

Samplers are just simple Ruby classes:

    class Who < Custodian::Samplers::Sampler
      describe "Logged in users"

      def sample
        `who`.lines.collect { |line| line.split.first }
      end

    end

You can load your own samplers with the `--samplers` option:

    $ custodian start --samplers=~/.custodian/samplers

### Clients

Unless you're crazy about JSON, you'll probably want to consume Custodian's API
with a *client*. Unfortunately, there are no clients for Custodian yet — you should make one!
