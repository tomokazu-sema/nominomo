class UsersController < ApplicationController
  def show
    @user = User.find_by(uid: params[:id])
  end
end
