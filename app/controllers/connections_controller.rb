class ConnectionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create

    # status : waiting approved declined
    connection_params = params.require(:connection).permit(:capi_1, :capi_2, :connection_type_id, :status)
    connection_params[:connection_type_id] = ConnectionType.find_by_name(params[:connection_type_id]).id
    connection = Connection.create(connection_params)
    render json: connection

  end

  def update

    params.require(:connection).permit(:status)
    connection = Connection.find(params[:id])
    connection.update(status: params[:status])
    render json: connection
  end

  def index

    if params[:capi_1].present? && params[:capi_2].present? && params[:filter].present?
      connection = Connection.find_connect(params[:filter], params[:capi_1], params[:capi_2])

    elsif params[:id].present? && params[:status]
      connection = Connection.find_with_status(params[:id], params[:status])

    elsif params[:id].present?
      connection = Connection.find_connect_by_capi_id(params[:id])

    else
      connection = Connection.all
    end

    render json: connection
  end

  def destroy
    connection = Connection.find(params[:id])
    connection.destroy
    render json: connect
  end

end
