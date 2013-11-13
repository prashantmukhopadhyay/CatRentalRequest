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

  def create
    @cat = Cat.new(params[:cat])
    @cat.age = Time.now.to_date.year - @cat.birthday.year

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages
    end
  end

  def new
    @cat = Cat.new
  end

  def update
    @cat = Cat.find_by_id(params[:id])

    if @cat.nil?
      render json: "NO SUCH REQUEST"
      return
    end

    @cat.update_attributes(params[:cat])
    @cat.age = Time.now.to_date.year - @cat.birthday.year

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])

    if @cat.nil?
      render json: "NO CAT"
      return
    end
  end

end
