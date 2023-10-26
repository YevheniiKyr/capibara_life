class User < ApplicationRecord
  has_secure_password

  def self.gen_jwt (id, name, role)
    JWT.encode(
      { id: id, name: name, role: role },
      # 'JWT_SECRET_KEY',
      ENV['JWT_SECRET_KEY'],
      'HS256',
      { exp: Time.now.to_i + 200 },
      )
  end
end
