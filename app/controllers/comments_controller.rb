class CommentsController < ApplicationController
  before_action :require_user

  def index
    @comment = Comment.order("created_at")
  end

  def create
    if @user.active?
      @space = Space.find(params[:space_id]) # note, must specify space_id, not just id. check params in binding.pry
      @comment = @space.comments.build(params.require(:comment).permit(:body))
      @comment.user = current_user

      if @comment.save
        flash[:notice] = "Your comment was successfully created"
        redirect_to space_path(@space)
      else
        render "spaces/show"
      end
    end
  end

  def vote
    comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: comment, user: current_user, vote: params[:vote])
    if @vote.valid?
      flash[:success] = "Your vote was counted."
      redirect_to :back
    else
      flash[:danger] = "You can only vote once."
      redirect_to :back
    end
  end

end