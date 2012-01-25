module Custodian
  class Server

    class Application

      def call(env)
        status = 200

        headers = {
          "Content-Type" => "application/json"
        }

        body = serialize reports

        [status, headers, [body]]
      end

      private

      def reports
        Custodian::Samplers.sample
      end

      # Serialize the given <tt>reports</tt> as JSON.
      def serialize(reports)
        hash = {}

        reports.each do |report|
          hash.merge! report.to_hash
        end

        hash.to_json
      end

    end

  end
end
