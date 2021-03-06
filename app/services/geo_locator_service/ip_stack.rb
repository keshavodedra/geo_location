require 'net/http'
module GeoLocatorService
  # Service to get geo location details from ipstack.
  class IpStack < ApplicationService
    # We can store and read this value from credentials.yml file.
    URL = 'http://api.ipstack.com/'.freeze
    ACCESS_KEY = '2810b7314e81e2841dccb720876f9b19'.freeze

    attr_reader :ip_address

    def initialize(val)
      @ip_address = val
    end

    def call
      response = Net::HTTP.get(URI.parse(ip_stack_url)).squish
      raise custom_error(no_response_error_msg) unless response.present?
      raise custom_error(invalid_req_error_msg) if JSON.parse(response)['error']

      {
        payload: JSON.parse(response),
        ip_address:
      }
    end

    private

    def ip_stack_url
      "#{URL + ip_address}?access_key=#{ACCESS_KEY}"
    end
  end
end
