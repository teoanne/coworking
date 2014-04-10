class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update]

  def index
    @spaces = Space.all
  end

  def show
   
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
  end

  def edit
    
  end

  def update
    if @space.update(space_params)
      flash[:success] = "Your co-working space details were updated."
      redirect_to root_path
    else
      flash[:error] = "There were some errors in your submission."
      render :new
    end

  end

  private

  def set_space
    @space = Space.find_by(params[:id])
  end

  def space_params
    params.require(:space).permit(:name, :street_address, :city, :country, :phone, :description, :cost)
  end

end