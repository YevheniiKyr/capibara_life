class ConnectionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create

    puts "HERE"
    # status : waiting approved declined
    connect_params = params.require(:connection).permit(:capi_1, :capi_2, :connection_type_id, :status)
    connect_params[:connection_type_id] = ConnectionType.find_by_name(params[:connection_type_id]).id
    connect = Connection.create(connect_params)
    respond_to do |format|
      format.json { render json: connect }
    end
  end

  def update

    params.require(:connection).permit(:status)
    @connection = Connection.find(params[:id])
    @connection.update(status: params[:status])
    respond_to do |format|
      format.json { render json: @connection }
    end
  end

  def index

    if params[:capi_1].present? && params[:capi_2].present? && params[:filter].present?
      puts 'AAAAAAAAAAAAAAAAA'
      if params[:filter] == "friends"
        connection_type_id = ConnectionType.find_by_name("friends").id
      end
      if params[:filter] == "spouse"
        connection_type_id = ConnectionType.find_by_name("married").id
      end
        connect = Connection.where("(capi_1 = :capi_1 AND capi_2 = :capi_2 OR capi_2 = :capi_1 AND capi_1 = :capi_2) AND connection_type_id = :connection_type_id ", capi_1: params[:capi_1], capi_2: params[:capi_2], connection_type_id: connection_type_id )
      respond_to do |format|
        format.json { render json: connect }
      end
      return
    end


    if params[:id].present? && params[:status].present?
      @capi_id = params[:id]
      @status = params[:status]
      connect = Connection.where("(capi_1 = :id OR capi_2 = :id) AND status = :status", id: @capi_id, status: @status)

      respond_to do |format|
        format.json { render json: connect }
      end
      return
    end
    if params[:id].present?
      @capi_id = params[:id]
      connect = Connection.where("(capi_1 = :id OR capi_2 = :id)", id: @capi_id)

      respond_to do |format|
        format.json { render json: connect }
      end
      return
    end

    connect = Connection.all
    respond_to do |format|
      format.json { render json: connect }
    end
  end

  def destroy
    @connection = Connection.find(params[:id])
    @connection.destroy()
    respond_to do |format|
      format.json { render json: @connection }
    end
  end

end
