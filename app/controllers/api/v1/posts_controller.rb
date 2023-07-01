class Api::V1::PostsController < ApplicationController
    def index
        @user = User.find(params[:user_id])
       @posts = @user.posts.includes(:comments)
        render json: @posts
      end
    
      def show
        @user = User.find(params[:user_id])
        @post = @user.posts.find_by(id: params[:id])
        return unless @post.nil?
    
            render json: @post
      end
    
      def create
        @user = User.find(params[:user_id])
        @post = @user.posts.build(post_params)
        @post.comments_counter = 0
        @post.likes_counter = 0
        if @post.save
           render json: @post, status: :created
        else
          render json: { error: @post.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end
    
      private
    
      def post_params
        params.require(:post).permit(:title, :text)
      end
end
