class ConnectionTypesController < ApplicationController

  skip_forgery_protection

  def create
    connect_params = params.require(:connection_type).permit(:name)
    connect = ConnectionType.create(connect_params)
    respond_to do |format|
      format.json { render json: connect }
    end

  end

  def index
    connections = ConnectionType.all
    respond_to do |format|
      format.json { render json: connections }
    end
  end

  def show
    id = params[:id]
    puts 'ID ',id
    @connection_type = ConnectionType.find(id)
    respond_to do |format|
      format.json { render json: @connection_type }
    end
    # @capibara.to_json
  end


end
