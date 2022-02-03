class ApplicationController < ActionController::API
  include JsonApiHandler
  include ErrorHandler
  include DefaultHandler
end
