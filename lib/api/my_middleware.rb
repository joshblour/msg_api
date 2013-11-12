class MyMiddleware < Faraday::Middleware


  def call(env)
    #set the current request authorization header from the current thread   
    env[:request_headers]["Authorization"] = "Token token=\"#{RequestStore.store[:token]}\""
    Rails.logger.debug("   API_REQUEST: #{env}") if defined?(Rails)
        
    @app.call(env)
  end
  
end