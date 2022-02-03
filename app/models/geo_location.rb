class GeoLocation < ApplicationRecord
  scope :my_geo_locations, ->(ip) { where(ip_address: ip) }
  scope :order_by_latest, -> { order('created_at DESC') }
end
