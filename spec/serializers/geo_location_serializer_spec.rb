RSpec.describe GeoLocationSerializer, type: :serializer do
  describe 'geo location' do
    it 'my_geo_location data from serializer' do
      @geo_location = FactoryBot.create(:geo_location, payload: JSON.parse('{"val":"test","val1":"test1","val2":"test2"}'), ip_address: '1.2.3.4')
      @serializer = GeoLocationSerializer.new(@geo_location)
      serialized_data = JSON.parse(@serializer.to_json)['data']
      serialized_data_attr = serialized_data['attributes']
      expect(serialized_data['id'].to_i).to eq(@geo_location['id'].to_i)
      expect(serialized_data_attr['ip_address']).to eq('1.2.3.4')
    end
  end
end
