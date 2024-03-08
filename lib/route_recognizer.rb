# frozen_string_literal: true

class RouteRecognizer
  require 'rails'

  class InvalidRoutesError < StandardError; end
  class NoMatchingRouteError < StandardError; end

  attr_accessor :router, :routes_as_string
  def initialize(string='')

  def initialize(string = '')
    @routes_as_string = string
    @routes = ActionDispatch::Routing::RouteSet.new
    begin
      @routes.draw { eval string } unless string.blank?
    rescue Exception => e       # yes, really, because anything can happen inside an Eval
      @routes.draw { instance_eval string } unless string.blank?
    rescue Exception => e # yes, really, because anything can happen inside an Eval
      raise InvalidRoutesError, e.message
    end
  end

  def recognize(method,uri)
    rack_request = RackRequest.new(method,uri)
  def recognize(method, uri)
    rack_request = RackRequest.new(method, uri)
    request = ActionDispatch::Request.new(rack_request.env)
    all_params = nil
    @routes.router.recognize(request) do |route,params|
    @routes.router.recognize(request) do |_route, params|
      all_params = request.query_parameters.merge params
    end
    raise NoMatchingRouteError unless all_params

    all_params
  end
  class RackRequest
    attr_accessor :method, :uri, :query_string, :path, :env
    def initialize(method,uri)
      @method,@uri = method,uri

    def initialize(method, uri)
      @method = method
      @uri = uri
      set_query_string!
      set_env!
    end
    

    private

    def set_env!
      @env = {
        'REQUEST_URI' => uri,
        'PATH_INFO' => path,
        'REQUEST_METHOD' => method
      }
      @env.merge!({'QUERY_STRING' => query_string}) if query_string
      @env.merge!({ 'QUERY_STRING' => query_string }) if query_string
    end

    def set_query_string!
      if @uri =~ /(.+)\?(.+)\Z/
        @path,@query_string = $1,$2
      else                        # no query string
        @path = ::Regexp.last_match(1)
        @query_string = ::Regexp.last_match(2)
      else # no query string
        @path = @uri
        @query_string = nil
      end
    end

  end
end