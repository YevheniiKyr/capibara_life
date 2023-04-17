# require 'securerandom'

class CapibarasController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_capi, only: %i[update, destroy, show]
  after_action :add_json_response, only: %i[update, destroy, create]

  def create
    puts 'WE ARE POST'

    capi_params = params.permit(:description, :weight, :money, :power, :name, :user_id, :image)
    # img = params.permit(:image)[:image]
    fileName = SecureRandom.uuid + '.jpg'
    puts 'PATH CHECK ', Rails.root.join('public/static').join(fileName)
    # FileUtils.move(img.tempfile, Rails.root.join('public/static').join(fileName))
    capi_params[:image] = fileName
    @capibara = Capibara.create(capi_params)
    # respond_to render json: @capibara
  end

  def update
    @capibara.update(capi_params)
  end

  def destroy
    @capibara.destroy
  end

  def deleteAll
    Capibara.destroy_all
  end

  def index

    if params[:id].present? && params[:filter].present?
      if params[:filter] == "friends"
        connection_type_id = ConnectionType.find_by_name("friends").id
        connections_friends = Connection.where("(capi_1 = :id OR capi_2 = :id) AND connection_type_id = :connection_type_id AND status = 'approved'", id: params[:id], connection_type_id: connection_type_id )

        if connections_friends.present?
          connections_friends = connections_friends.map do |connection|
            if connection.capi_1.to_s == params[:id].to_s
              puts "true"
               connection.capi_2
            else
              puts "false"
              puts connection.capi_1
              puts params[:id]
               connection.capi_1
            end
          end
          @capibara = Capibara.where(id: connections_friends)
          puts "CAPI ", @capibara
        else
          @capibara = nil
        end
      end

      if params[:filter] == "spouse"

        puts "WE ARE AT THE START"
        connection_type_id = ConnectionType.find_by_name("married").id
        puts "WE FOUND CON TYPE ID ", connection_type_id

        spouse_connection = Connection.where("(capi_1 = :id OR capi_2 = :id) AND connection_type_id = :connection_type_id AND status = 'approved'", id: params[:id], connection_type_id: connection_type_id).first
        puts "WE FOUND SPOUSE_CON "

        if spouse_connection.present?
          spouse_id = if spouse_connection.capi_1 == params[:id]
                        spouse_connection.capi_2
                      else
                        spouse_connection.capi_1
                      end
          puts "WE FOUND SPOUSE_ID ", spouse_id

          @capibara = Capibara.find(spouse_id)
          puts @capibara.name
        else
          @capibara = nil
        end
      end
      if params[:filter] == "requests"
        connections = Connection.where("(capi_1 = :id OR capi_2 = :id) AND status = 'proposed'", id: params[:id])
        if connections.present?
          connections = connections.map do |connection|
            if connection.capi_1 == params[:id]
              connection.capi_2
            else
              connection.capi_1
            end
          end
          @capibara = Capibara.where(id: connections)
        else
          @capibara = nil
        end
      end


    else
      if params[:id].present?
        @capibara = Capibara.find_by_user_id(params[:id])
        puts "NO HER PLS"
      else
        if params[:ids].present?
          @capibara = Capibara.where(id: params[:ids])
        else
          @capibara = Capibara.all
        end
      end
    end
    # puts @capibara
    # result.to_json
    respond_to do |format|
      format.json { render json: @capibara }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @capibara }
    end
    # @capibara.to_json
  end

  private

  def set_capi
    @capibara = Capibara.find(params[:id])
  end

  def capi_params
    params.require(:capibara).permit(:name, :image, :description, :weight, :age, :money, :power)
  end

  def add_json_response
    respond_to do |format|
      format.json { render json: @capibara }
    end
    # response.body = { capi: @capibara }.to_json
  end
end
