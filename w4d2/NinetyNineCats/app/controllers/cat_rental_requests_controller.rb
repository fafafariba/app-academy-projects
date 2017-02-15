class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_requests = CatRentalRequest.all
    render json: @cat_rental_requests
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat = Cat.find(@cat_rental_request.cat_id)
    render json: @cat_rental_request
  end

  def new
    @cats = Cat.all
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.status = "pending"

    if @cat_rental_request.save
      redirect_to cats_url
    else
      render json: @cat_rental_request.errors.full_messages, status: 422
    end
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
