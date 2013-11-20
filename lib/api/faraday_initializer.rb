require "faraday"
require "faraday_middleware"
require 'api/my_middleware'
require 'logger'


$api = Faraday.new(:url => ENV['MSG_API_URL'] || 'http://msg-api.herokuapp.com' ) do |conn|
  conn.use MyMiddleware
  conn.use FaradayMiddleware::EncodeJson
  conn.use Faraday::Response::Logger, Logger.new('faraday.log')
  conn.request :json
  conn.response :json, :content_type => /\bjson$/
  conn.adapter Faraday.default_adapter
end
