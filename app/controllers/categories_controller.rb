class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]

  def new
    @category = Category.new
  end

  def create
    
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = "Your country was added to the list. Please add your coworking space."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(params[:id])
  end
  
end