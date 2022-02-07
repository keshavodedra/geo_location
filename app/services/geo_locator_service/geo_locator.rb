module GeoLocatorService
  # geo-locator service interception for deciding geo locator service provider.
  class GeoLocator < ApplicationService
    # We can store and read this value from credentials.yml file (EX. IpStack, IPLocate).
    GEO_SERVICE_PROVIDER = 'IpStack'.freeze

    attr_reader :ip_address

    def initialize(req)
      @ip_address = req.try(:remote_ip)
    end

    def call
      @ip_address = find_my_ip unless Rails.env.production?
      raise custom_error(ip_address_error_msg) unless ip_address.present?

      geo_service_name.constantize.new(ip_address).call
    end

    private

    def find_my_ip
      # For development purpose
      IpAddressService::FindMyIp.call
    end

    def geo_service_name
      "GeoLocatorService::#{GEO_SERVICE_PROVIDER}"
    end
  end
end
