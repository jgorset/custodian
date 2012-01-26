# Custodian

Custodian is a lightweight resource monitor that makes it really easy
to sample metrics and display them anywhere.

## Usage

### Server

Start Custodian and configure it to sample metrics every 60 seconds and expose
them over HTTP on port 5100:

    $ custodian --port=5100 --interval=60

#### Samplers

Custodian aggregates metrics from *samplers*, and ships with samplers for popular figures
such as logged in users and load averages. That's interesting and all, but custom
samplers are all the rage.

```ruby
class RegisteredUsers < Custodian::Samplers::Sampler
  describe "Registered users"

  def sample
    Users.count
  end
end
```

You can load additional samplers with the `--samplers` option.

    $ custodian --port=5100 --interval=60 --samplers=~/.samplers

### Clients

Unless you're crazy about JSON, you'll want to consume Custodian's API with a
*client*. Unfortunately, there are no clients for Custodian yet — you should make one!
