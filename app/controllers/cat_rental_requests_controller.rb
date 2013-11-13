class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
  end

  def create
    @request = CatRentalRequest.new(params[:cat_rental_request])

    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      render json: @request.errors.full_messages
    end
  end

  def show
    @request = CatRentalRequest.find_by_id(params[:id])
    if @request.nil?
      render json: "NO SUCH REQUEST"
      return
    end
  end

  def edit
    @request = CatRentalRequest.find_by_id(params[:id])
    if @request.nil?
      render json: "NO SUCH REQUEST"
      return
    end
  end

  def update
    @request = CatRentalRequest.find_by_id(params[:id])

    if @request.nil?
      render json: "NO SUCH REQUEST"
      return
    end

    @request.update_attributes(params[:cat_rental_request])

    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      render json: @request.errors.full_messages
    end
  end

  def approve
    @request = CatRentalRequest.find_by_id(params[:id])
    if @request.nil?
      render json: "NO SUCH REQUEST"
      return
    end

    @request.approve!

    redirect_to :back
  end

  def deny
    @request = CatRentalRequest.find_by_id(params[:id])
    if @request.nil?
      render json: "NO SUCH REQUEST"
      return
    end

    @request.deny!

    redirect_to :back
  end


end
