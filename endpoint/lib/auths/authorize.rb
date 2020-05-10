# frozen_string_literal: true

module Auths
  # Authorization Class
  class Authorize
    def obtain_userinfo_with_google(access_token)
      endpoint_host = ENV['AUTH_GOOGLE_USERINFO_ENDPOINT_HOST']
      endpoint_path = ENV['AUTH_GOOGLE_USERINFO_ENDPOINT_PATH']
      res = get_endpoint(endpoint_host, endpoint_path, access_token)
      unless res.status == 200
        raise(Auths::Error::Unauthorized, \
              "error on obtaining user data: #{res.status}")
      end
      info = JSON.parse(res.body)
      {
        name: info['given_name'].present? ? info['given_name'] : info['name'],
        full_name: info['name'],
        email: info['email'],
        image: info['picture'],
        identifier: info['sub']
      }
    end

    private

    def get_endpoint(host, path, opt, query = nil)
      conn = setup_http_connection(host, opt)
      if query.nil?
        conn.get path
      else
        conn.get path, query
      end
    end

    def setup_http_connection(host, opt)
      conn = Faraday.new(url: host) do |client|
        client.request :url_encoded
        client.request :oauth2, opt, token_type: 'bearer' unless opt.nil?
        client.adapter Faraday.default_adapter
      end
      conn
    end
  end
end
