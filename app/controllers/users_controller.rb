require 'jwt'

class UsersController < ApplicationController
  skip_forgery_protection

  def create
    puts 'HERE'
    user_params = params.require(:user).permit(:name, :role, :password)
    puts 'user pass ', user_params[:password]
    puts 'user name ', user_params[:name]
    @user = User.create(user_params)
    unless @user.id
      render json: "Ім'я вже зайнятo"
      return
    end
      token = genJWT(@user.id, @user.name, @user.role)
      respond_to do |format|
        format.json { render json: token }
      end
    end

  def index
    @users = User.all
    render json: @users
  end

  def login
    user_params = params.require(:user).permit(:name, :password)
    puts 'user pass ', user_params[:password]
    puts 'user name ', user_params[:name]
    @user = User.find_by_name(user_params[:name])


    unless @user.present?
      render json: "Імя крінж", status: 400
      return
    end


    authorized = @user.authenticate(user_params[:password])
    unless authorized.present?
      render json: "Пароль чи ім'я неправильні(((", status: 400
      return
    end

    token = genJWT(@user.id, @user.name, @user.role)
    render json: token, status: 200

  end

  private

  def genJWT (id, name, role)
    JWT.encode(
      { id: id, name: name, role: role },
      ENV['JWT_SECRET_KEY'],
      'HS256',
      { exp: Time.now.to_i + 36000 },
    )
  end

end

