class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    @spaces = Space.all
  end

  def show
    @comment = Comment.new # this corresponds to the comments show on the space show page
    respond_to do |format|
      format.html
      format.json { render json: @space }
      format.xml { render xml: @space }
    end
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)

    if @space.save(space_params)
      flash[:notice] = "You have successfully added a coworking space!"
      redirect_to root_path
    else
      render :new
    end
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

  def vote
     @vote = Vote.create(voteable: @space, user: current_user, vote: params[:vote]) # this last params here includes both up vote and down vote
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You are only allowed to vote once"
        end
        redirect_to :back 
      end
      format.js # leaving it blank will make it automatically look for the vote js view template
    end
  end


  private

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:name, :street_address, :city, :country, :phone, :description)
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You need to be logged in to do that."
    end
  end

end