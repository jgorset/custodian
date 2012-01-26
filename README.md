# Custodian

Custodian is a lightweight resource monitor that makes it really easy
to sample metrics and display them anywhere.

## Usage

### Server

Start Custodian and configure it to sample metrics every 60 seconds
and expose them over HTTP on port 5100:

    $ custodian start --port=5100 --interval=60

#### Samplers

Custodian aggregates metrics from *samplers*, and ships with samplers
for popular figures:

    $ custodian samplers
    15 samplers:

      cpu       CPU usage
      ram       RAM usage
      disk      Disk usage
      load      Load average
      who       Logged in users
      ...

##### Rolling your own

CPU, RAM and disk usage is interesting and all, but custom samplers are all the rage.
Samplers are just Ruby classes, so it's really easy to roll your own:

```ruby
class RegisteredUsers < Custodian::Samplers::Sampler
  describe "Registered users"

  def sample
    Users.count
  end
end
```

#### Configuration

Custodian may be configured from `~/.custodian`.

```ruby
require "~/.samplers/registered_users"
require "~/.samplers/active_users"

samplers do
    defaults

    register RegisteredUsers
    register ActiveUsers
end
```

### Clients

Unless you're crazy about JSON, you'll want to consume Custodian's API
with a *client*. Unfortunately, there are no clients for Custodian yet —
you should make one!
