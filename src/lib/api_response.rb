module ApiResponse
  class ResponseData
    def self.success(data, status = 200)
      {
        data: data,
        status: status
      }.to_json
    end

    def self.error(message, status = 400)
      {
        error: message,
        status: status
      }.to_json
    end
  end
end 