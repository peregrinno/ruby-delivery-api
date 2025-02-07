module Controllers
  class ApplicationController
    include ApiResponse
    include AuthMiddleware
    include Sinatra::Helpers

    def initialize(request)
      @request = request
      @params = request.params
      request.body.rewind
      body_content = request.body.read
      @body = JSON.parse(body_content) rescue {}
    end

    private

    def json_halt(status, message)
      {
        status: status,
        response: { error: message }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      }
    end
  end
end 