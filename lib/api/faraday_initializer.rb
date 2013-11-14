require "faraday"
require "faraday_middleware"
require 'api/my_middleware'
require 'logger'

if Rails.env == 'development'
 url = 'http://localhost:3001'
else
  url = 'http://msg-api.herokuapp.com'
end

$api = Faraday.new(:url => url ) do |conn|
  conn.use MyMiddleware
  conn.use FaradayMiddleware::EncodeJson
  conn.use Faraday::Response::Logger, Logger.new('faraday.log')
  conn.request :json
  conn.response :json, :content_type => /\bjson$/
  conn.adapter Faraday.default_adapter
end
