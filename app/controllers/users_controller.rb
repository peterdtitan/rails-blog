class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    return unless @user.nil?

    redirect_to users_path
  end

  private

  def load_and_authorize_user
    @user = User.find(params[:id])
    authorize! :read, @user
  end
end
