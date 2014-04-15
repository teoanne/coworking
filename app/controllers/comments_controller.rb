class CommentsController < ApplicationController
  before_action :require_user

  def index
    
  end

  def create
    @space = Space.find(params[:space_id]) # note, must specify space_id, not just id. check params in binding.pry
    @comment = @space.comments.build(params.require(:comment).permit(:body)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Your comment was successfully created"
      redirect_to space_path(@space)
    else
      render "spaces/show"
    end
  end

end