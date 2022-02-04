require 'net/http'

module IpAddressService
  # Service is used to get my ip address.
  class FindMyIp < ApplicationService
    def call
      response = Net::HTTP.get(ip_address_url).squish
      raise custom_error(ip_address_error_msg) unless response.present?

      response
    end

    private

    def ip_address_url
      URI.parse('http://checkip.amazonaws.com/')
    end
  end
end
