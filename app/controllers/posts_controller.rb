class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(2)
    @recent_comments = Comment.where(post_id: @posts)
      .includes(:user)
      .select('DISTINCT ON (post_id) *')
      .order(:post_id, created_at: :desc)
      .limit(5)
  end
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find_by(id: params[:id])
    return unless @post.nil?
    redirect_to user_posts_path(@user)
  end
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end
  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
