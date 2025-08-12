require 'jwt'
require 'rack'

class AuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if (request.path == '/login' && request.post?) || (request.path == '/users' && request.post?)
      return @app.call(env)
    end

    if env['REQUEST_METHOD'] == 'OPTIONS'
      @app.call(env)
    else
      begin
        unless env['HTTP_AUTHORIZATION']
          return unauthorized_response
        end

        token = env['HTTP_AUTHORIZATION'].split(' ')[1]
        unless token
          return unauthorized_response
        end

        decoded = JWT.decode(token, 'JWT_SECRET_KEY', true, algorithm: 'HS256')
        env['user'] = decoded
        @app.call(env)
      rescue JWT::DecodeError
        unauthorized_response
      end
    end
  end

  private

  def unauthorized_response
    [401, { 'Content-Type' => 'application/json' }, [{ message: "Unauthorized" }.to_json]]
  end
end
