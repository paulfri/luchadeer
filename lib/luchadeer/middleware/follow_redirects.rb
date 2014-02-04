require 'faraday'
require 'set'
require 'luchadeer/error'

module Luchadeer
  module Middleware
    class FollowRedirects < Faraday::Response::Middleware
      FOLLOW_LIMIT = 3

      def call(env)
        follow_redirect(env, FOLLOW_LIMIT)
      end

    private

      def follow_redirect(env, follows)
        request_body = env[:body]
        response = @app.call(env)

        response.on_complete do |env|
          if follow_redirect?(env, response)
            raise Luchadeer::Error::RedirectLimitReached, response if follows.zero?

            env      = update_env(env, request_body, response)
            response = follow_redirect(env, follows - 1)
          end
        end

        response
      end

      def follow_redirect?(env, response)
        env[:method] == :get and [301, 302, 303, 307].include? response.status
      end

      def update_env(env, request_body, response)
        env[:url] += response['location']
        env[:method] = :get

        [:status, :response, :response_headers].each do |key|
          env.delete key
        end

        env
      end
    end
  end
end

Faraday::Response.register_middleware follow_redirects: Luchadeer::Middleware::FollowRedirects
