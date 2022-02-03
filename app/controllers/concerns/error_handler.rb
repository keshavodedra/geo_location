# error handler for common exceptions
module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
    rescue_from Exception, with: :error_generic

    def render_not_found_error(error)
      render json: error_response(:not_found, error.message), status: :not_found
    end

    def render_standard_error(error)
      render json: error_response(:unprocessable_entity, error.message, 'Please try after some time'), status: :unprocessable_entity
    end

    def route_not_found
      render json: error_response(:not_found, 'API you are trying to access does not exist', 'Please check requested URL'), status: :not_found
    end

    def error_generic(error)
      render json: error_response(:unprocessable_entity, error.message), status: :unprocessable_entity
    end

    def error_response(status, details, extra = '')
      {
        error: [
          {
            status:
          },
          title: status.to_s.titleize,
          details:,
          extra:
        ]
      }
    end
  end
end
