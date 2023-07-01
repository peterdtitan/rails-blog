class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    per_page = 2
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @posts = @user.posts.order(created_at: :desc).limit(per_page).offset([offset, 0].max)

    if @posts.empty?
      flash.now[:notice] = 'This user has no posts.'
    else
      @recent_comments = Comment.where(post_id: @posts)
        .includes(:user)
        .select('DISTINCT ON (post_id) *')
    end
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

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find_by(id: params[:id])
    @post.destroy

    redirect_to user_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
