FactoryBot.define do
  factory :geo_location do
    payload { JSON.parse('{"val":"test","val1":"test1","val2":"test2"}') }
    ip_address { '1.2.3.4.5' }
  end
end
