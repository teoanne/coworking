class CategoriesController < ApplicationController

  def show
    #@category = Category.find_by(params[:name])\
    @category = Category.find(params[:id])
  end

  #def create
    
    #@category = Category.new(params.require(:category).permit(:name))

    #if @category.save
      #flash[:notice] = "Hello Admin. Your country was added. There are now #{@category.count} countries on the list."
      #redirect_to home_path
    #else
      #render :new
    #end
  #end
  
end