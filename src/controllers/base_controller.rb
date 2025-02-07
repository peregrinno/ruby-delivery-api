module Controllers
  class BaseController < ApplicationController
    include ApiResponse
    include AuthMiddleware

    def initialize(request)
      @request = request
      @params = request.params
      request.body.rewind
      body_content = request.body.read
      @body = JSON.parse(body_content) rescue {}
    end
  end
end 