require "json"

module Custodian

  # The API class is a Rack-compatible* application that encapsulates
  # Custodian's interface.
  # 
  # * http://rack.rubyforge.org/doc/files/SPEC.html.
  class API

    # Render the JSON representation of each sample.
    #
    # env - A Hash of CGI-like headers describing the
    #       environment under which the request was received.
    #
    # Returns an Array describing the HTTP response.
    def call(env)
      status = 200

      headers = {
        "Content-Type" => "application/json"
      }

      body = Custodian::Samplers.compatible.collect do |sampler|
        { description: sampler.description, sample: sampler.sample }
      end.to_json

      [status, headers, [body]]
    end

  end

end
