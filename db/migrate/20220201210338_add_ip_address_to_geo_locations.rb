class AddIpAddressToGeoLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :geo_locations, :ip_address, :string
  end
end
