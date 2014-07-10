class Admin::CategoriesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @category = Category.new
  end

  def create
    
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = "Hello Admin. Your region was added."
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def require_admin
    redirect_to home_path unless current_user.admin?
  end

end