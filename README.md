# Custodian

Custodian is a lightweight resource monitor that makes it really easy
and really awesome to sample metrics.

## Usage

### Server

Start Custodian and configure it to expose metrics on port 5100:

    $ custodian --port=5100

#### Samplers

Custodian aggregates metrics from *samplers*, and ships with a whole bunch of them for popular
figures like CPU, RAM and disk usage. That's interesting and all, but custom samplers are all the rage:

```ruby
class RegisteredUsers < Custodian::Samplers::Sampler
  describe "Registered users"

  def self.sample
    Users.count
  end
end
```

You can load your own samplers with the `--samplers` option.

    $ custodian --samplers=~/.samplers

### Clients

Unless you're crazy about JSON, you'll want to consume Custodian's API with a
*client*. There are no clients for Custodian yet, but you should totally make one.

## I love you

Johannes Gorset made this. You should [tweet me](http://twitter.com/jgorset) if you can't get
it to work. In fact, you should tweet me anyway.
