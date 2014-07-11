class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:vote, :new]
  before_action :require_same_user, only: [:edit, :update]

  def index
    #@spaces = Space.all.paginate(:page => params[:page], :per_page => 5) #
    @spaces = Space.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
    #all.sort_by{|x| x.total_votes}.reverse
    
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
    @space = Space.new(space_params.merge!(user_id: current_user.id))
    #category = Category.create(params[:category_name]) 
    #@space.user = current_user

    if @space.save(space_params)
      flash[:notice] = "You have successfully added a coworking space!"
      redirect_to home_path
    else
      flash[:danger] = "Sorry your co-working space could not be added right now."
      render :new
    end
  end

  def edit
    
  end

  def update
    if @space.update(space_params)
      flash[:success] = "Your co-working space details were updated."
      redirect_to home_path
    else
      flash[:danger] = "There were some errors in your submission."
      render :new
    end

  end

  def vote
     @vote = Vote.create(voteable: @space, user: current_user, vote: params[:vote]) # this last params here includes both up vote and down vote
    
    if @vote.valid?
      @space.actual_votes!
    end

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

  def search
    @results = Space.search_by_name(params[:search_term])
  end


  private

  def set_space
    @space = Space.find_by(slug: params[:id])
  end

  def space_params
    params.require(:space).permit(:name, :street_address, :city, :country, :phone, :description, :main_photo, :additional_photos, :remote_main_photo_url)#, category_name:[]) # note added category_name to capture the data submitted through the form
  end

  def require_same_user
    access_denied unless logged_in? && (@space.user == current_user || current_user.admin?)
  end

end