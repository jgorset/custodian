# Custodian

Custodian is a lightweight resource monitor that makes it really easy
to sample metrics and display them anywhere.

## Usage

### Server

Start Custodian and configure it to sample metrics every 60 seconds and expose
them over HTTP on port 5100:

    $ custodian start --port=5100 --interval=60

#### Samplers

Custodian ships with samplers for popular metrics such as CPU, RAM and disk usage:

    $ custodian samplers
    15 samplers:
    
      cpu       Samples CPU usage
      ram       Samples RAM usage
      disk      Samples disk usage
      load      Samples load average
      who       Samples logged in users
      ...

##### Making your own samplers

Samplers are just Ruby classes!

```ruby
class Hits < Custodian::Samplers::Sampler
  describe "Samples hits to NGINX"

  def sample
    open("/var/log/nginx/access.log").lines.count
  end

end
```

### Clients

Unless you're crazy about JSON, you'll want to consume Custodian's API
with a *client*. Unfortunately, there are no clients for Custodian yet.
You should make one!
