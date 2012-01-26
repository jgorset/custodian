require "json"

module Custodian

  # The API class encapsulates a rack-compatible application that
  # renders the JSON representation of each sample.
  class API

    def call(env)
      status = 200

      headers = {
        "Content-Type" => "application/json"
      }

      body = Custodian::Samplers.list.collect do |sampler|
        { description: sampler.description, sample: sampler.sample } if sampler.compatible?
      end.compact.to_json

      [status, headers, [body]]
    end

  end

end
