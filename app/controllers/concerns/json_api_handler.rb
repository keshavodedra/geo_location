# json api handler for formatting api response into json.
module JsonApiHandler
  extend ActiveSupport::Concern
  included do
    include JSONAPI::Fetching
    include JSONAPI::Filtering
    include JSONAPI::Pagination
    include JSONAPI::Errors
  end
end
