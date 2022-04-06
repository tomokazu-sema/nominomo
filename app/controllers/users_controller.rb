class UsersController < ApplicationController
  before_action :move_to_root

  def show
    @user = User.find_by(uid: params[:id])
  end

  private

  def move_to_root
    redirect_to root_path unless user_signed_in? && current_user.uid == params[:id]
  end
end
