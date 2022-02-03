RSpec.describe GeoLocation, type: :model do
  before(:each) do
    GeoLocation.destroy_all
  end

  describe 'geo location' do
    before(:each) do
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'),
                                       ip_address: IpAddressService::FindMyIp.call)
      FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'), ip_address: '1.2.3.4')
    end

    it 'my_geo_locations' do
      puts 'Scope: my_geo_locations'
      expect(GeoLocation.my_geo_locations('1.2.3.4').count).to eq(1)
    end

    it 'my_geo_locations' do
      puts 'Scope: order_by_latest'
      expect(GeoLocation.order_by_latest.first.ip_address).to eq('1.2.3.4')
    end
  end
end
