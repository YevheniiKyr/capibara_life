class CapibarasController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_capi, only: %i[update, destroy, show]
  after_action :add_json_response, only: %i[update, destroy]

  def create
    Capibara.create(capi_params)
  end

  def update
    @capibara.update(capi_params)
  end

  def destroy
    @capibara.destroy
  end

  def index
    @capibara = Capibara.all
    puts @capibara
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
