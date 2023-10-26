class CapibarasController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_capi, only: %i[ destroy, show]
  # after_action :add_json_response, only: %i[ destroy, create]

  def create

    capi_params = params.permit(:description, :weight, :money, :power, :name, :user_id, :image)
    # img = params.permit(:image)[:image]
    fileName = SecureRandom.uuid + '.jpg'
    Rails.root.join('public/static').join(fileName)
    # FileUtils.move(img.tempfile, Rails.root.join('public/static').join(fileName))
    capi_params[:image] = fileName
    @capibara = Capibara.create(capi_params)

    render json: @capibara
  end

  def update
    capi_params = params.permit(:description, :weight, :money, :power, :name, :user_id, :image, :id)

    if params[:image].present?
      fileName = SecureRandom.uuid + '.jpg'
      # puts 'PATH CHECK ', Rails.root.join('public/static').join(fileName)
      # FileUtils.move(img.tempfile, Rails.root.join('public/static').join(fileName))
      capi_params[:image] = fileName
    end
    capi_params = capi_params.to_h.compact
    @capibara = Capibara.find(params[:id])
    if @capibara.update(capi_params)
      render json: @capibara
    else
      render json: 'cant update'
    end

  end

  def destroy
    @capibara.destroy
  end

  def delete_all
    Capibara.destroy_all
  end

  def index

    if params[:id].present? && params[:filter].present?
      @capibara = case params[:filter]
                  when "friends" then Capibara.find_friends(params[:id])
                  when "spouse" then Capibara.find_spouse(params[:id])
                  when "requests" then Capibara.find_requests(params[:id])
                  end

    else
      if params[:id].present?
        @capibara = Capibara.find_by_user_id(params[:id])
      else
        if params[:ids].present?
          @capibara = Capibara.where(id: params[:ids])
        else
          @capibara = Capibara.all
        end
      end
    end

    render json: @capibara

  end

  def show
    render json: @capibara
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
  end

end

