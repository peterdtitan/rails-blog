class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    render json: @comments
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
