require 'rails_helper'

RSpec.describe 'Api::GeoLocationsController', type: :request do
  before(:each) do
    GeoLocation.destroy_all
  end

  describe 'GET /v1/geo_locations' do
    before(:each) do
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'), ip_address: '1.2.3.4.5')
    end

    it 'should get a list of geo locations' do
      puts 'geo_location/index: should get all list'
      get '/api/geo_locations?all=true'
      parsed_response = JSON.parse(response.body)
      expect((parsed_response['data']).length).to eq(6)
      expect(response.status).to eq 200
    end

    it 'should get a list with pagination' do
      puts 'geo_location/index: should get a list with pagination'
      get '/api/geo_locations?all=true&page[size]=3&page[number]=1'
      parsed_response = JSON.parse(response.body)
      expect((parsed_response['data']).length).to eq(3)
      expect(response.status).to eq 200
    end

    it 'should get a list with filter by static ip' do
      puts 'geo_location/index: should get a list with filter by static ip'
      get '/api/geo_locations?all=true&filter[ip_address_eq]=1.2.3.4.5'
      parsed_response = JSON.parse(response.body)
      expect((parsed_response['data']).length).to eq(1)
      expect(response.status).to eq 200
    end

    it 'should get a list by current ip' do
      puts 'geo_location/index: should get a list with current ip'
      get '/api/geo_locations'
      parsed_response = JSON.parse(response.body)
      expect((parsed_response['data']).length).to eq(5)
      expect(response.status).to eq 200
    end
  end

  describe 'POST /v1/geo_locations' do
    it 'should add new record' do
      puts 'geo_location/create: should add new record'
      expect do
        post '/api/geo_locations'
      end.to change { GeoLocation.count }.from(0).to(1)
      expect(response.status).to eq 201
    end
  end

  describe 'DELETE /v1/geo_locations/:geo_location_id' do
    it 'should delete newly added record' do
      puts 'geo_location/destroy: should delete newly added record'
      geo_location = FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'), ip_address: '1.2.3.4')
      expect do
        delete "/api/geo_locations/#{geo_location.id}"
      end.to change { GeoLocation.count }.from(1).to(0)

      puts 'geo_location/destroy: should give 204 status code'
      expect(response.status).to eq 204
    end
  end

  describe 'DELETE /v1/geo_locations/delete_my_locations' do
    before(:each) do
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
    end

    it 'should delete my all records' do
      puts 'geo_location/delete_my_locations: should delete my all records'
      expect do
        delete '/api/geo_locations/delete_my_locations'
      end.to change { GeoLocation.count }.from(3).to(0)

      puts 'geo_location/delete_my_locations: should give 204 status code'
      expect(response.status).to eq 204
    end
  end
end
