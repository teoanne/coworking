class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comments_params])
  end

  private

  def comments_param
    params.require(:comment).permit(:body)
  end

end