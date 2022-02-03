module Error
  # custom error class for that override error.
  class CustomError < StandardError
    attr_reader :status, :error, :message

    def initialize(message = nil, status = nil)
      @error = 422
      @status = status || :unprocessable_entity
      @message = message || 'Something went wrong'
    end
  end
end
