require 'jwt'

class UsersController < ApplicationController
  skip_forgery_protection

  def create

    user_params = params.require(:user).permit(:name, :role, :password)
    user = User.create(user_params)
    unless user.id
      render json: "Ім'я вже зайнятo"
      return
    end
    token = User.gen_jwt(user.id, user.name, user.role)
    render json: {token: token}

  end

  def index
    users = User.all
    render json: users
  end

  def login
    user_params = params.require(:user).permit(:name, :password)
    user = User.find_by_name(user_params[:name])

    unless user.present?
      render json: "Імя неправильне", status: 400
      return
    end

    authorized = user.authenticate(user_params[:password])
    unless authorized.present?
      render json: "Пароль чи ім'я неправильні", status: 400
      return
    end

    token = User.gen_jwt(user.id, user.name, user.role)
    render json: token, status: 200

  end

  def check

    token = request.headers['Authorization'].split(' ')[1]
    unless token
      render json: { msg: 'you are not authorized' }, status: 401
    end

    decoded = JWT.decode(token, 'JWT_SECRET_KEY')
    unless decoded
      render json: { msg: 'you are not authorized' }, status: 401
    end
    new_token = User.gen_jwt(decoded[0]["id"], decoded[0]["name"], decoded[0]["role"])
    render json: new_token
  end

  private

end

