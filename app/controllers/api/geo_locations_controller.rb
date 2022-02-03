module Api
  # geo location apis.
  class GeoLocationsController < ApplicationController
    before_action :set_geo_location, only: [:destroy]

    # GET /geo_locations
    def index
      jsonapi_filter(collections, ransackable_attributes) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # POST /geo_locations
    def create
      service_response = GeoLocatorService::GeoLocator.call(request)

      @geo_location = GeoLocation.new(payload: service_response[:payload],
                                      ip_address: service_response[:ip_address])

      if @geo_location.save
        render jsonapi: @geo_location, status: :created
      else
        render jsonapi_errors: @geo_location.errors, status: :unprocessable_entity
      end
    end

    # DELETE /geo_locations/1
    def destroy
      @geo_location.destroy
      render nothing: true, status: :no_content
    end

    # DELETE /delete_my_locations
    def delete_my_locations
      my_locations.destroy_all
      render nothing: true, status: :no_content
    end

    private

    def jsonapi_meta(resources)
      pagination = jsonapi_pagination_meta(resources)

      { pagination: } if pagination.present?
    end

    def set_geo_location
      @geo_location = GeoLocation.find(params[:id])
    end

    def find_my_ip
      return IpAddressService::FindMyIp.call unless Rails.env.production?

      request.remote_ip
    end

    def collections
      return my_locations unless params[:all]

      GeoLocation.all.order_by_latest
    end

    def my_locations
      GeoLocation.my_geo_locations(find_my_ip).order_by_latest
    end

    def ransackable_attributes
      %w[id ip_address]
    end
  end
end
