# common base service for common tasks
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  private

  def custom_error(message, status = :unprocessable_entity)
    raise Error::CustomError.new(message, status)
  end

  def ip_address_error_msg
    'Can not detect your IpAddress'
  end

  def no_response_error_msg
    'There is no response from IpStack'
  end

  def invalid_req_error_msg
    'Invalid request'
  end
end
