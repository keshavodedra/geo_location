# default logic/methods that you want to run for each apis.
module DefaultHandler
  extend ActiveSupport::Concern
  included do
    before_action :set_headers

    def set_headers
      # for developent purpose we can use '*',
      # but we should restrict to allow for perticular domain only, we can store its value in yml file and can read from that file.
      headers['Access-Control-Allow-Origin'] = '*'
      headers['X-Frame-Options'] = 'deny'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
  end
end
