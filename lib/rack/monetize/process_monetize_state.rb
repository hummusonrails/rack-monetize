module Rack
  module Monetize
    class ProcessMonetizeState
      def initialize(app)
        @app = app
      end

      def call(env)
        req = ::Rack::Request.new(env)

        # If there is no `monetization_state` field ignore this middleware
        return @app.call(env) unless req.params['monetization_state']

        # Otherwise calculate the signature and check that it matches
        if req.params['monetization_state'] && check_monetization_state(req.params['monetization_state'])
          @app.call(env)
        else
          [403, {}, ['']]
        end
      end

      private

      def check_monetization_state(state)
        if (state == 'stopped'|| state == 'pending' || state == 'started' || state == 'undefined')
          true
        end
      end
    end
  end
end