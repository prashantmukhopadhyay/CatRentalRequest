class CatsController < ApplicationController


  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    if @cat.nil?
      render json: "NO CAT"
      return
    end
  end

  def new
    @cat = Cat.new
  end

end
