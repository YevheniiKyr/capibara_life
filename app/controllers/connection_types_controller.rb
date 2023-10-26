class ConnectionTypesController < ApplicationController

  skip_forgery_protection

  def create
    connect_params = params.require(:connection_type).permit(:name)
    connect = ConnectionType.create(connect_params)
    render json: connect

  end

  def index
    connections = ConnectionType.all
    render json: connections
  end

  def show
    id = params[:id]
    connection_type = ConnectionType.find(id)
    render json: connection_type

  end


end
