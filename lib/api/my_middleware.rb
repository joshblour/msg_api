class MyMiddleware < Faraday::Middleware
  def initialize(app, options={})
    @app = app
  end

  def call(env)
    #set the current request authorization header from the current thread   
    env[:request_headers]["Authorization"] = "Token token=\"#{RequestStore.store[:token]}\""
    Rails.logger.debug("   API_REQUEST: #{env}") if defined?(Rails)
        
    @app.call(env).on_complete do
      Rails.logger.debug("          ---> #{env[:status]}") if defined?(Rails)
      return env[:body]
    end
  end
end