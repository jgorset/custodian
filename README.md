# Custodian

Custodian is a lightweight resource monitor that makes it really easy
and really awesome to sample metrics.

## Usage

### Server

Start Custodian and configure it to expose its metrics on port 5100:

    $ custodian --port=5100

![Example](https://github.com/jgorset/custodian/raw/master/docs/images/example.png)

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

You can load your own samplers with the `--samplers` option.

    $ custodian --samplers=~/.samplers

### Clients

Unless you're crazy about JSON, you'll want to consume Custodian's API with a
*client*. Unfortunately, there are no clients for Custodian yet — you should make one!
