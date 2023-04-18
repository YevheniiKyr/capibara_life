# app/middleware/auth_middleware.rb
# require 'jwt'
# require 'rack'
#
# class AuthMiddleware
#   def initialize(app)
#     @app = app
#   end
#
#   def call(env)
#     if env['REQUEST_METHOD'] == 'OPTIONS'
#       @app.call(env)
#     else
#       begin
#
#         unless env['HTTP_AUTHORIZATION']
#           puts "no Auth"
#           return unauthorized_response
#         end
#
#
#         puts "we have header"
#         puts env['HTTP_AUTHORIZATION'].to_s
#         token = env['HTTP_AUTHORIZATION'].split(' ')[1]
#         if !token
#           return unauthorized_response
#         end
#         puts "we have token"
#         puts 'CODED'
#
#         decoded = JWT.decode(token, ENV['SECRET_KEY'], true, algorithm: 'HS256')
#         puts 'DECODED'
#         env['user'] = decoded
#         puts "VERIFIED USER #{decoded['_id']} #{decoded['email']} #{decoded['role']}"
#         @app.call(env)
#       rescue JWT::DecodeError
#         return unauthorized_response
#       end
#     end
#   end
#
#   private
#
#   def unauthorized_response
#     [401, { 'Content-Type' => 'application/json' }, [{ msg: "Unauthorized" }.to_json]]
#
#     end
#
# end
